Return-Path: <linux-spi+bounces-2985-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509E98CAFE4
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2024 16:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A8DC28504E
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2024 14:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2405A77117;
	Tue, 21 May 2024 14:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xlt6Klh9"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687AF8004B;
	Tue, 21 May 2024 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716300130; cv=none; b=m7Ual5wE6Roc2T3aaXYOjml7T1oqqdAooaoOxOZJJEVKLVa5N6FbndV9Lrw3wYPBoTNUUUTjV3g8vCQS3oL6OGCP/sYBBT2i4FNQ/zI+jgV3xINhANUjX+wRTNozvGjooGreMK+4aNmutTuuEDL9JH/F4nITea17nf7Qul6kQ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716300130; c=relaxed/simple;
	bh=wQfXmBBSl62bShtRXM5vAkuDb1swhN55UnYuHS+luY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q34vAvF1yv8qqXlkYNUXmVbhN83Ws+I+ntYhrICVrv6uEY58xCxOtYA7kMSwUnGq6SWTdX116+TdMjrPZ7joWhaKnqnmk20qlSaZPEmaxMfrBt5kSsUiZvEJwVsBDt37d1cDF30RwXyiydTYGntz0CU8pbiCREaQCdcY2coBbNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xlt6Klh9; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716300128; x=1747836128;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wQfXmBBSl62bShtRXM5vAkuDb1swhN55UnYuHS+luY8=;
  b=Xlt6Klh9cGmbfa6pbzq6pPu67JfFzxYtYXEXez+SZcMcyNGQf7thMJZo
   nTPBnsKMHWjES3dmxwjlf1TQNRzrG1Vs5ridajY1GqHghPjvDXwN1zMr3
   pdrz9f6Is4T/tXS/BWDSoDWETVAWSavBmy4RExTnNmQmur+RhZLHbar9d
   wDsnzCkr60Xziz4FW/F3vkylCjldgpxuAFcNxr/O8R1ZxBTnrIAPDqMGB
   dg76goY+ws1pRhWFMuUtSt6iKIJffxEDnIGzE2AdEojrlVguhLvH5rhnm
   N4Y5VgE7EixL7qCxwB1UyrfIx2+m63SVSDKsbFSeiGFG1Q/qFUOJRc6zJ
   A==;
X-CSE-ConnectionGUID: HFNzCFDwTbewJsjxC8AKCA==
X-CSE-MsgGUID: Brtutuj6RFi2/8pIYAo3/Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12722094"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="12722094"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 07:02:07 -0700
X-CSE-ConnectionGUID: NnpcorRrRxOl9UgpIatVcQ==
X-CSE-MsgGUID: ywsKWMMdTo21rmxXRI8mCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="70350936"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 07:02:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s9Q42-00000009fqg-2JFR;
	Tue, 21 May 2024 17:02:02 +0300
Date: Tue, 21 May 2024 17:02:02 +0300
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
Message-ID: <ZkypWt2AxfjUQSgO@smile.fi.intel.com>
References: <20240517171103.221856-1-andriy.shevchenko@linux.intel.com>
 <e81d43f8-a3ba-41b4-a86f-af2d6943e917@sirena.org.uk>
 <Zke2yG-WPkaWg5PV@smile.fi.intel.com>
 <CAL_JsqKA7AnY7w3sjrT+khrat348v7uNpAP1+FZ=mdYMhJkf3Q@mail.gmail.com>
 <ZksqPiSLY8OlE5lT@smile.fi.intel.com>
 <20240520203600.GA1424819-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240520203600.GA1424819-robh@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, May 20, 2024 at 03:36:00PM -0500, Rob Herring wrote:
> On Mon, May 20, 2024 at 01:47:26PM +0300, Andy Shevchenko wrote:
> > On Fri, May 17, 2024 at 03:19:51PM -0500, Rob Herring wrote:
> > > On Fri, May 17, 2024 at 2:58 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Fri, May 17, 2024 at 06:24:37PM +0100, Mark Brown wrote:
> > > > > On Fri, May 17, 2024 at 08:11:03PM +0300, Andy Shevchenko wrote:

...

> > > > > > SSP stands for Serial Synchronous Protocol and has nothing to do with
> > > > > > UART, also known as USART, where 'A' stands for Asynchronous.
> > > > > >
> > > > > > Move the SSP bindings to where it belongs.
> > > > >
> > > > > It's a serial device which is also used for other applications (the
> > > > > other one upstream being audio) so I can see where the current binding
> > > > > comes from and it's not super obvious that spi is especially better
> > > > > here.
> > > >
> > > > Hmm... okay. Then it's question to DT people. Consider this as a report.
> > > > Because UART (aka serial) is definitely not the place for SPI/SSP bindings
> > > > either.
> > > 
> > > Move it when it is converted.
> > 
> > The problem is that somebody added a binding (in YAML) for SPI PXA2xx
> > in the spi/ folder while this one kept unconverted.
> 
> Ah, well that detail was missed.
> 
> > 
> > If it dangles more, it might be that we will have two asynchronous bindings
> > for the co-existed drivers.
> 
> Looks like all that is needed is adding the compatible strings and 
> 'dmas' property to spi/marvell,mmp2-ssp.yaml. The examples in the old 
> binding have other stuff, but looks like that's garbage.

I'm not an expert in DT, anybody to join them in a nicest possible way?

-- 
With Best Regards,
Andy Shevchenko



