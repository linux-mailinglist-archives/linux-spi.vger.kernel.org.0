Return-Path: <linux-spi+bounces-2956-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEC18C9B9D
	for <lists+linux-spi@lfdr.de>; Mon, 20 May 2024 12:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3ED1F22E85
	for <lists+linux-spi@lfdr.de>; Mon, 20 May 2024 10:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE8F51C2A;
	Mon, 20 May 2024 10:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YikS92US"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAED3535D2;
	Mon, 20 May 2024 10:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716202053; cv=none; b=r8d0JDwpsqz5A86EfwWut58N/gz5Fr5bI1/zTS/y0DVbXkwhmsc2RR4BgRYhKKA/6F8fmo3OKrTCtOJd/nM28//DnppkeeefA5ePz5XWcLb5lt408sg4uqZPT+LPVwrDhd13H1BLyoHqtaOigtUcofpCfw023/a7grtgJCA6x7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716202053; c=relaxed/simple;
	bh=D9++WKjDS1JW5+8Ykh1MaJ5rmIn6HukYfEAwjK6ICP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuLPsie6gZKzY+mz0aogCd58uATzlPdo5jH00n85Bg+9pKdk8ob16S/zPawADYecbthzCwVcZ5QPMYieyN15uXHg9K2Y823Ay4dHMeVbqa9oi91DcNPMU2u09wrZTwTN/q1GGyxs8ZoyGXfIgUDTb0AhDXwDtHyjK4iEir73GhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YikS92US; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716202052; x=1747738052;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=D9++WKjDS1JW5+8Ykh1MaJ5rmIn6HukYfEAwjK6ICP8=;
  b=YikS92US3FbwD+sIV/OZHevl9vHei2Ao5/MZ/TsTFf0wtOeIadbEtjiY
   qNcT3lhQjAhIZNKH5ciL3JRpH0Ond+NvHPo9z671T/JEps9hfb0zgFFhP
   mYTQNH1Uf7J+59nwZdNFmWE6thEQ6A3yJpdIodTVPqXISh3ddXz8BARH/
   y2V+LZGMI5kllHFtZ+2SAvYuIQXjeqCMBQglkQLLZ0A7SUKfdDuQD+R4Q
   LxOrBs84xbOxZS8vvkO3ELe8HDFAW7jHOvH2JAQjmq3zSpKjGRlE5JFyH
   XPzVtemNO0XwPnf2FCL6lakKyILMdZH5L1+NvBTwW+vdsyjiQqhG64hKH
   A==;
X-CSE-ConnectionGUID: uEiUKmxzRNmo7c1aXVpdWw==
X-CSE-MsgGUID: M2gkk0dYSpy4KpJJ1ZVxMA==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="37699955"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="37699955"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 03:47:31 -0700
X-CSE-ConnectionGUID: BZqp9f3TSsaDbsMe3VOPPg==
X-CSE-MsgGUID: HEqFDtDlRESSJGXjGQOiPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="55729331"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 03:47:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s90YA-00000009Hy4-2iF6;
	Mon, 20 May 2024 13:47:26 +0300
Date: Mon, 20 May 2024 13:47:26 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rob Herring <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v1 1/1] spi: pxa2xx: Move PXA SSP bindings to the correct
 folder
Message-ID: <ZksqPiSLY8OlE5lT@smile.fi.intel.com>
References: <20240517171103.221856-1-andriy.shevchenko@linux.intel.com>
 <e81d43f8-a3ba-41b4-a86f-af2d6943e917@sirena.org.uk>
 <Zke2yG-WPkaWg5PV@smile.fi.intel.com>
 <CAL_JsqKA7AnY7w3sjrT+khrat348v7uNpAP1+FZ=mdYMhJkf3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKA7AnY7w3sjrT+khrat348v7uNpAP1+FZ=mdYMhJkf3Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 17, 2024 at 03:19:51PM -0500, Rob Herring wrote:
> On Fri, May 17, 2024 at 2:58 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, May 17, 2024 at 06:24:37PM +0100, Mark Brown wrote:
> > > On Fri, May 17, 2024 at 08:11:03PM +0300, Andy Shevchenko wrote:

...

> > > > SSP stands for Serial Synchronous Protocol and has nothing to do with
> > > > UART, also known as USART, where 'A' stands for Asynchronous.
> > > >
> > > > Move the SSP bindings to where it belongs.
> > >
> > > It's a serial device which is also used for other applications (the
> > > other one upstream being audio) so I can see where the current binding
> > > comes from and it's not super obvious that spi is especially better
> > > here.
> >
> > Hmm... okay. Then it's question to DT people. Consider this as a report.
> > Because UART (aka serial) is definitely not the place for SPI/SSP bindings
> > either.
> 
> Move it when it is converted.

The problem is that somebody added a binding (in YAML) for SPI PXA2xx
in the spi/ folder while this one kept unconverted.

If it dangles more, it might be that we will have two asynchronous bindings
for the co-existed drivers.

> Until then, I don't care too much. SPI seems better than serial at least.
> The sound part is its own binding/node (something we wouldn't do today).

-- 
With Best Regards,
Andy Shevchenko



