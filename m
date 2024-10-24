Return-Path: <linux-spi+bounces-5350-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 717449ADD55
	for <lists+linux-spi@lfdr.de>; Thu, 24 Oct 2024 09:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AF8E1F223EF
	for <lists+linux-spi@lfdr.de>; Thu, 24 Oct 2024 07:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBAC171E6E;
	Thu, 24 Oct 2024 07:12:29 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2984017333D
	for <linux-spi@vger.kernel.org>; Thu, 24 Oct 2024 07:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729753949; cv=none; b=pAbVCrgomNViohprGAjc4PHt9K3vV+RyHYg8J/1/ZaglLMeOBHZGZvHKmkxAjZJQby2wSLHd0wW2Yus4/Qa4MRoappClVtKeACGOr/HhRDthXkQFimBIWGaFbBD02sRuRMDQJAVlVQ3/8/SWa/NaM+yoId79EMwitACZUE4yazo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729753949; c=relaxed/simple;
	bh=GCWpgMbuuAyDpUPrFid6j3N3x6rERzcJP7AAz0OnnPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H1Tyo4H5RD1o9hiXQd9NJzfaIFaN3jU/HouHHCzmmERBWyI4o54LzkUWRLQ/rA1RteLoO4VqbD0HEJJrU1C3bFuxJXarS0yotZkiqdwTXrSfNM6V0u7wdcEp4DKuAzsN94PBmEnJFQsTLGQuD6ag9ioRCxdvteJqrynO12yoJ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPV6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.92)
	(envelope-from <s.kerkmann@pengutronix.de>)
	id 1t3s0z-0000cR-P8; Thu, 24 Oct 2024 09:12:13 +0200
Message-ID: <ed331ddc-9b61-459f-b7a9-90b7442d0166@pengutronix.de>
Date: Thu, 24 Oct 2024 09:12:11 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] spi: cadence-quadspi: STIG mode results in timeouts
 for Micron MT25QL01 flash
To: Mark Brown <broonie@kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Dhruva Gole <d-gole@ti.com>, Yoshitaka Ikeda <ikeda@nskint.co.jp>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@pengutronix.de
References: <c2cdfba1-afcc-4a77-8890-7da49c4b73c2@pengutronix.de>
 <43b6b750-3f7d-437f-a62e-ab2dba06827a@leemhuis.info>
 <1127989f-3175-49c0-9611-e30194b04018@sirena.org.uk>
From: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Content-Language: en-US, de-DE
In-Reply-To: <1127989f-3175-49c0-9611-e30194b04018@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.kerkmann@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

Hello,

On 22.10.24 18:39, Mark Brown wrote:
> On Mon, Oct 21, 2024 at 11:58:07AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> 
>> The culprit afaics was merged for v6.3-rc1. Makes me wonder: would
>> reverting this now even an option to fix this in mainline, or would this
>> just lead to a regression for someone else?
> 
> Given the description of the original commit I'd expect so.  My guess
> would be that this is either tuning of the lengths involved or a quirk
> that's needed to disable STIG on some devices.

Adding a quirk came to my mind as well. I unfortunately do not have a different
QSPI chip to test against to see if it is a specific combination of peripheral
and chip  or if using STIG is generally broken on the socfpga. With trying
different lenghts do you refeer to `CQSPI_STIG_DATA_LEN_MAX`?

Regards,
Stefan

-- 
Pengutronix e.K.                       | Stefan Kerkmann             |
Steuerwalder Str. 21                   | https://www.pengutronix.de/ |
31137 Hildesheim, Germany              | Phone: +49-5121-206917-128  |
Amtsgericht Hildesheim, HRA 2686       | Fax:   +49-5121-206917-9    |


