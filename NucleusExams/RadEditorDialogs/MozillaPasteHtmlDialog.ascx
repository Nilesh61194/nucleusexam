<%@ Control Language="C#" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI.Editor" TagPrefix="tools" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI.Widgets" TagPrefix="widgets" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI.Dialogs" TagPrefix="dialogs" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


<script type="text/javascript">
	Type.registerNamespace("Telerik.Web.UI.Widgets");

	Telerik.Web.UI.Widgets.MozillaPasteHtmlDialog=function(element) {
		Telerik.Web.UI.Widgets.MozillaPasteHtmlDialog.initializeBase(this,[element]);
		this._holder=null;
		this._document=null;
		this._container=null;
		this._confirmButton=null;
		this._cancelButton=null;
	}

	Telerik.Web.UI.Widgets.MozillaPasteHtmlDialog.prototype={
		initialize: function() {
			Telerik.Web.UI.Widgets.MozillaPasteHtmlDialog.callBaseMethod(this,"initialize");

			this._initChildren();
		},

		_initChildren: function() {
			this._holder=$get("holder");
			this._document=this._holder.contentWindow.document;
			this._document.write("<html><head></head><body></body></html>");
			this._document.close();
			this._document.designMode="on";
			this._setupBody=Function.createDelegate(this,this._setupBody);
			window.setTimeout(this._setupBody,0);

			this._confirmButton=$get("InsertButton");
			this._confirmButton.title=localization["Paste"];
			this._cancelButton=$get("CancelButton");
			this._cancelButton.title=localization["Cancel"];


			$addHandlers(this._confirmButton,{ "click": this._confirmButtonClickHandler },this);
			$addHandlers(this._cancelButton,{ "click": this._cancelButtonClickHandler },this);
		},

		clientInit: function(clientParameters) {
			var dialogNS=Telerik.Web.UI.Dialogs.CommonDialogScript;
			if(this._container) {
				this._container.innerHTML="&nbsp;";
				this._container.focus();
			}
			if(clientParameters&&clientParameters.dialogTitle) {
				document.title=clientParameters.dialogTitle;//RadWindow will try to set the title based on the Url's document.title. Therefore update it.
				Telerik.Web.UI.Widgets.Polling.waitFor(function() {
					return !!dialogNS.get_windowReference();
				}).always(function() {
					dialogNS.get_windowReference().set_title(clientParameters.dialogTitle);
				});
			}
		},

		_setupBody: function() {
			this._container=this._document.body;
			this._container.style.margin="0px";
			this._container.style.padding="0px";
			this._container.style.backgroundColor="#fff";
		},

		_confirmButtonClickHandler: function(e) {
			var eventArgs=new Sys.EventArgs();
			eventArgs._content=this._container.innerHTML;
			eventArgs.get_content=function() { return this._content; };
			Telerik.Web.UI.Dialogs.CommonDialogScript.get_windowReference().close(eventArgs);
		},

		_cancelButtonClickHandler: function(e) {
			Telerik.Web.UI.Dialogs.CommonDialogScript.get_windowReference().close();
		},

		dispose: function() {
			$clearHandlers(this._confirmButton);
			$clearHandlers(this._cancelButton);
			this._holder=null;
			this._container=null;
			this._document=null;
			this._confirmButton=null;
			this._cancelButton=null;

			Telerik.Web.UI.Widgets.MozillaPasteHtmlDialog.callBaseMethod(this,"dispose");
		}
	}

	Telerik.Web.UI.Widgets.MozillaPasteHtmlDialog.registerClass("Telerik.Web.UI.Widgets.MozillaPasteHtmlDialog",Telerik.Web.UI.RadWebControl,Telerik.Web.IParameterConsumer);
</script>
<div class="redMainContainer">
	<div class="redMozillaPasteHtmlDialog">
		<div class="redWrapper">
			<table cellpadding="0" cellspacing="0" class="reDialog" style="width: 99%; margin-left: 2px; margin-bottom: 4px;">
				<tr>
					<td>
						<div>
							<script type="text/javascript">
								document.write(localization["UseControlVMessage"]);
							</script>
						</div>
						<iframe src="javascript:''" id="holder" width="99%" height="250px" frameborder="0" style="border: solid 1px #000;"></iframe>
					</td>
				</tr>
			</table>
		</div>

		<div class="redActionButtonsWrapper redActionButtonsAbsoluteWrapper redActionButtonsWrapperExternal" runat="server">

			<button type="button" id="InsertButton" class="rfdPrimaryButton rfdFlatButton">
				<script type="text/javascript">
					setInnerHtml("InsertButton",localization["Paste"]);
				</script>
			</button>
			<button type="button" id="CancelButton" class="rfdFlatButton">
				<script type="text/javascript">
					setInnerHtml("CancelButton",localization["Cancel"]);
				</script>
			</button>

		</div>


	</div>
</div>
