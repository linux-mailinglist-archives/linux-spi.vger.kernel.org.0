Return-Path: <linux-spi+bounces-6278-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFC0A08E36
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 11:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A0803A7C77
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 10:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E912209F56;
	Fri, 10 Jan 2025 10:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="SV/VcX3+"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DB018FC80;
	Fri, 10 Jan 2025 10:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736505636; cv=none; b=oxAeV5c3VX9iqTzmbOXRNIYhihQ/FwUdDgz47RAjAHUK96Yi87pVe+RGmyruLtD6XFTLrH4v8ndLrmrQoFe9Gc93aWAqbMNjFLWJYOORQQUCIMk89kJHK4auPtj2/BPT8qcy0DcakQryqee92MerI4wNH/DsQrGqhCab/lRmlhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736505636; c=relaxed/simple;
	bh=XnoGI27sAzxteRudWbN7mWItU1ketiCVzBfubfH2tGE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQSdEFT9MJHGiOw9ziz/yLjnn7gut9HEcMiLTuTrBrVz678p1HB1piK0XU4Yqk2H2BT1My+8L4xoUGweGUBUtsDWBB1O0MIFuv1yZ17XMfIbQyqdyxJQObsSY1VCfrF+mhaGTVgzwsX7WxjbfpT3me3OezNIxGS2TnSE7S69XvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=SV/VcX3+; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 08F7814840C9;
	Fri, 10 Jan 2025 11:40:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1736505632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oXMjZB7unGdAPHawTHDHYq7OtFRZiyCjd74uE75bGDg=;
	b=SV/VcX3+cLJP9SeuPvjDTUtHYVDrj++lsg5W7vxIm9ME+cc8FEnlaFoIq9bPRiyETqA+4d
	OeDUPDQp1fENFuqJnEE16Vr4Obz2f0S+L0zPcghKF1565yEWtK5Oqt7+KSOyqiuIUSsAbP
	x8/Y24eDUxeEYO4QLF5uHUBsHUYauTDtiDtO1v6uBC21KPw9u5PUB/7ktgyNZRxhJfdpTt
	rr/Yb8E3HbTXPPVWrQu+qlK1cEu9pP3yEmOEMi0YKQJFZ089RneynkFzICrChbFAUBLQLG
	6wtH8kWZ1z+97misSriigLrGPbNNmhw2uUZt3OvHV7r/ag6NifiRkXtsMdKwvg==
Date: Fri, 10 Jan 2025 11:40:26 +0100
From: Alexander Dahl <ada@thorsis.com>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@microchip.com>,
	Varshini Rajendran <varshini.rajendran@microchip.com>,
	Mark Brown <broonie@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>
Subject: Re: [PATCH v3 2/2] spi: atmel-quadspi: Add support for sama7g5 QSPI
Message-ID: <20250110-married-program-83bc1a997ce8@thorsis.com>
Mail-Followup-To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@microchip.com>,
	Varshini Rajendran <varshini.rajendran@microchip.com>,
	Mark Brown <broonie@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>
References: <20241128174316.3209354-1-csokas.bence@prolan.hu>
 <20241128174316.3209354-3-csokas.bence@prolan.hu>
 <20250109-carat-festivity-5f088e1add3c@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250109-carat-festivity-5f088e1add3c@thorsis.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello,

Am Thu, Jan 09, 2025 at 05:27:58PM +0100 schrieb Alexander Dahl:
> Hello Bence,
> 
> I had another round of intense looking at the code, this time I
> focused on pm_runtime handling.  Although I just learned about the
> basic concepts, I think the ported patch has some mistakes.  I'll
> comment here, because I don't have a SAMA7G5 to test, and I'm not
> confident enough to fix the code, but I think it's worth reporting.
> See below.
> 
> Am Thu, Nov 28, 2024 at 06:43:15PM +0100 schrieb Csókás, Bence:
> > From: Tudor Ambarus <tudor.ambarus@microchip.com>
> > 

[…]

> > +	/* Release the chip-select. */
> > +	ret = atmel_qspi_reg_sync(aq);
> > +	if (ret) {
> > +		pm_runtime_mark_last_busy(&aq->pdev->dev);
> > +		pm_runtime_put_autosuspend(&aq->pdev->dev);
> > +		return ret;
> > +	}
> > +	atmel_qspi_write(QSPI_CR_LASTXFER, aq, QSPI_CR);
> > +
> > +	return atmel_qspi_wait_for_completion(aq, QSPI_SR_CSRA);
> > +}
> 
> This function atmel_qspi_sama7g5_transfer() seems to be called from
> atmel_qspi_exec_op() through ops->transfer() only.  I think the two
> lines in the error handling of atmel_qspi_reg_sync() lead to
> unbalanced calls of pm_runtime_xxx.  Compare with
> atmel_qspi_transfer() which has no calls to pm_runtime, everything is
> covered by atmel_qspi_exec_op() in this case where the pm_runtime
> calls surround ->set_cfg() and ->transfer().  Right?

This problem has been addressed in downstream kernel (linux4sam) by
Claudiu Beznea back in 2023 already:

https://github.com/linux4sam/linux-at91/commit/e59f646f516088fdab6d8213d8acda0c1063ec21

[…]

> The whole call tree from atmel_qspi_sama7g5_setup() downwards is not
> covered by pm_runtime get and put calls, although heavily doing i/o.
> Further down in atmel_qspi_setup() there's a write to QSPI_SCR which
> seems to be handled correctly.

Same for this:

https://github.com/linux4sam/linux-at91/commit/5ff0e74c1d548599fe85113e2f1817cb8a052b15

Some hunks of that seem to have made it to upstream, not sure?

Maybe Microchip should upstream those fixes, now that SAMA7G5 support
was ported to mainline?

Greets
Alex

