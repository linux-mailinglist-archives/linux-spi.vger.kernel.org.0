Return-Path: <linux-spi+bounces-9960-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A006CB510C9
	for <lists+linux-spi@lfdr.de>; Wed, 10 Sep 2025 10:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC7694849BB
	for <lists+linux-spi@lfdr.de>; Wed, 10 Sep 2025 08:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA3E30FC2D;
	Wed, 10 Sep 2025 08:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GvA8Plv/"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4580D3164A9
	for <linux-spi@vger.kernel.org>; Wed, 10 Sep 2025 08:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491704; cv=none; b=rcxILyLHySoISnjsYegX9phTipsnL1sXNgaWc6KzeT5sISbTX61LwJ+HiindkIP0abc2kApcxd1afl7HccesCFGXWb7G2ykeBktFA1u+dh9JeJyxZVRZKWdkM8fb/b2vUAJucCkSrASI51PNauL4/q+P5WMuFmryvgwP/7Ap3Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491704; c=relaxed/simple;
	bh=/kahrPSq62XJHZQ14MPrvCMIwTqR0KelcfDlCN+v/dY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VcAP6hHg+Tgp6YuhlHhSo9E8Zqvdu8hzi96XJnAbCHP/DPGXgYLPoLRW1kxHtfvIM73UiPkFccNsfGwO0VuvEsaybu0zjRsHZRHegoxtMNT6Wgs3+gjgWXMbZTm+WV+hjzyNKJotWlDg7Y9yMTvwkB4yx1xnq5IrHeomOcJopuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GvA8Plv/; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 245CE4E40C1A;
	Wed, 10 Sep 2025 08:08:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EA1F8606D4;
	Wed, 10 Sep 2025 08:08:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8C13D102F28F5;
	Wed, 10 Sep 2025 10:07:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757491699; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=DFuMg5iWYPLms98ctieeK6in5Im02OMPaCPSyPba7ZA=;
	b=GvA8Plv/Bm3qf4rmSFr6vepw/my5SAJ/b5OZcdpTNyQ5WtxbZGfpVqYc4r8CSJxWfL8k5f
	RKGyE+I8KnfqHvD8fkRjM+mtMmYKAIDZrcfAKae1cK6YUfIILV5Oj9+OoRE+HFJAdRZIJy
	LQ3MUvhqqbjcEYBtIEZSdG9CSvWOEa2o4rtQWRofenQr2CtCiq7O28ZBHDIJzrvh68EgUo
	DHzX+IMxfqsC+IbdjjHRcZhTqOCDaRTWx1oe0cTIa/09q+knQFqcuW6XjE3+T5r4Si0ixA
	yt4neKDUnm7bOlriSUQvUZDjSV+ex9znq3S+tGSCwLOiO4ES4LBj7Z+mGrVbTA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Santhosh Kumar K <s-k6@ti.com>,  richard@nod.at,  vigneshr@ti.com,
  tudor.ambarus@linaro.org,  pratyush@kernel.org,  mwalle@kernel.org,
  p-mantena@ti.com,  linux-spi@vger.kernel.org,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
  a-dutta@ti.com,  u-kumar1@ti.com,  praneeth@ti.com
Subject: Re: [RFC PATCH 01/10] spi: spi-mem: Introduce support for tuning
 controller
In-Reply-To: <2f051eae-61c7-4bff-9f85-cf37b02a7ea3@sirena.org.uk> (Mark
	Brown's message of "Thu, 14 Aug 2025 13:34:38 +0100")
References: <20250811193219.731851-1-s-k6@ti.com>
	<20250811193219.731851-2-s-k6@ti.com>
	<6c35baad-a332-4b0a-96ca-1cdb3840ad94@sirena.org.uk>
	<20487e7f-33dd-4b65-b1a8-5bb8a06ef859@ti.com>
	<2f051eae-61c7-4bff-9f85-cf37b02a7ea3@sirena.org.uk>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Wed, 10 Sep 2025 10:07:50 +0200
Message-ID: <87y0qmenmx.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 14/08/2025 at 13:34:38 +01, Mark Brown <broonie@kernel.org> wrote:

> On Thu, Aug 14, 2025 at 05:04:33PM +0530, Santhosh Kumar K wrote:
>> On 14/08/25 01:56, Mark Brown wrote:
>
>> > Should we have something that blocks these tuning required modes witho=
ut
>> > the appropriate tuning, and/or allows discovery of which modes require
>> > this tuning?  This all feels very landmineish - client drivers just ha=
ve
>> > to know when tuning is required.
>
>> The flash's maximum operating frequency determines whether PHY tuning is
>> required, as we need tuning in case of Cadence controller for frequencies
>> over 50 MHz.
>
> That's entirely specific to the Candence controller from the sounds of
> it, that makes it hard to write a client driver if you need to know
> exactly what the controller you're dealing with is and what it's
> requirements are.
>
>> And we do check for this condition - see Patch 07/10,
>> cqspi_phy_op_eligible_sdr(), which currently verifies the flash frequency
>> against 166 MHz. This logic can be improved by implementing both min and=
 max
>> frequency checks, will update in the following version.
>
> I can't actually tell how that verifies if the tuning has been done
> appropriately TBH, at least not without more effort than I'd care to
> (and the tuning only gets added in patch 10?).

Santhosh, do you need more inputs? Or can you send an updated version?

I am still thinking about the interface on the spi-mem/spi-nand side,
but please iterate so we can move forward.

Thanks,
Miqu=C3=A8l

