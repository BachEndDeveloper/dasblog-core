﻿using DasBlog.Services;
using DasBlog.Web.Settings;
using Microsoft.AspNetCore.Mvc;

namespace DasBlog.Web.Controllers
{
	/// <summary>
	/// How clients can post Activities to this actor's outbox 
	/// </summary>
	public class OutboxController : DasBlogBaseController
	{
		private readonly IDasBlogSettings dasBlogSettings;

		public OutboxController(IDasBlogSettings settings) : base(settings)
		{
			dasBlogSettings = settings;
		}

	}
}
