Return-Path: <linux-spi+bounces-5605-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEF49BB531
	for <lists+linux-spi@lfdr.de>; Mon,  4 Nov 2024 13:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DA65B21D00
	for <lists+linux-spi@lfdr.de>; Mon,  4 Nov 2024 12:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027E21B6D12;
	Mon,  4 Nov 2024 12:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="bqca/QcP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08AD188700;
	Mon,  4 Nov 2024 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730725084; cv=none; b=qU8GKpf0Zfpyt+T8WfxWzg19nuqTFdmaeDISMx49NCgdsP3bVVmOfhcY6e4P1H6sIuBfsi7p9VapevagQX7zL3xyGT5WG3c8NP3VEUBUGjwmKkDbCBrgaQAhQ3jCaLJ9Qs0iLhY98/39XSLtUeJDRfOHaZAWbPgVe9UZlzBzwW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730725084; c=relaxed/simple;
	bh=uWo6MBCWDHenPWPskw9Mha5xIIzATKNCwLzi94uWMXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4l1kpdZdeKRy9g/GZfP7IfOTZ8qLAnFXolbnF8s4gS1FCp2InVPccjhK96Qokhj15QC7tKM1lTTVlcV4ij9KE/ZHpx6ejMp70bjwAAXfEEk+03sS6p7NhCGnE2BQCDFS7sTKEw/TZa+RFu+XYrOrZ3vKwDANj9slbYSpXDMC5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=bqca/QcP; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9CCD5148169C;
	Mon,  4 Nov 2024 13:48:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1730724500; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AYvItjWc7e4pPd+CCBu2oWSX6jirooxClqMJ96xxtcw=;
	b=bqca/QcPRvHxrrDCthh0DkY0v87ETWZmLpK9jTIXcC/BG7tkQyu0CdN9HTbXkbxPI289eW
	GN+J8oOvw9/q1uPpjlyZyLsdwoX2UPaUzUfIBqIIf52Ok6vlNNFpy9qTwzGJsLJvjfFdMK
	mdv3O4Vcx/K+RH5ah7wXRsBdDAaNQFjRbWzDA62iipIndAUsPiqyEkweOnNEgU5wlmmSY9
	m+zOIDM/MOQaPtuMEQYLYmmDlomqXV0WmGeU0a5pJfSFZLo/u82YB3usg2jWJbTxObtH1v
	ZYT66nD8mg+tRIIIje0D0CXhWa/qDU7wPLjMEEcjCkgePV1oo5nKLSek/PPIfg==
Date: Mon, 4 Nov 2024 13:48:12 +0100
From: Alexander Dahl <ada@thorsis.com>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Varshini Rajendran <varshini.rajendran@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH v2] spi: atmel-quadspi: Create `atmel_qspi_ops` to
 support newer SoC families
Message-ID: <20241104-vanilla-operating-de19b033f0a8@thorsis.com>
Mail-Followup-To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>,
	Tudor Ambarus <tudor.ambarus@linaro.org>, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Varshini Rajendran <varshini.rajendran@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
References: <20241030084445.2438750-1-csokas.bence@prolan.hu>
 <7cc95e52-7509-44eb-8e30-d518283e7d87@linaro.org>
 <2b310b54-c215-40fa-b6d4-81faf75a8c9e@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b310b54-c215-40fa-b6d4-81faf75a8c9e@prolan.hu>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Am Wed, Oct 30, 2024 at 01:37:52PM +0100 schrieb Csókás Bence:
> Hi,
> 
> On 2024. 10. 30. 12:09, Tudor Ambarus wrote:
> > I think it's fine to split sama7g5 addition in smaller steps. But please
> > add the sama7g5 support in the same patch set, otherwise this patch
> > doesn't make sense on its own.
> 
> Well, actually, we're using SAMA5D2. My goal was just to somewhat harmonize
> upstream with the vendor kernel so that we may contribute other patches that
> we have made on top of the latter, or in the future, take patches from
> upstream and apply it to our vendor kernel-based tree. This patch was only
> meant to lay the groundworks for future SAMA7G5 support. I can of course
> send the "other half" of the original patch if needed, but I wouldn't want
> it to hold up this refactor.

It would actually be better if vendor would bring their stuff
upstream, so there's no need for a vendor kernel.  Did you talk to
Microchip about their upstreaming efforts?  What was the answer?

Greets
Alex

> 
> > Also, if you think you significantly changed the code of authors, I
> > think it's fine to overwrite the authorship. Otherwise, try to keep the
> > authorship and specify your contributions above your S-o-b tag.
> 
> I don't know if it counts as "significantly changed", I split out parts of a
> patch that were relevant for our device, and made small adjustments to make
> it correctly apply to master. I didn't find a descriptive enough tag for
> this, so I just went with Cc:, but if so desired, I could change it to a
> S-o-b, Co-authored-by, Suggested-by etc.
> 
> Bence
> 
> 

