Return-Path: <linux-spi+bounces-11360-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3725DC7072F
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 18:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 56FFE3517DC
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 17:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D14327C1F;
	Wed, 19 Nov 2025 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MmGg7LNf"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DAA33A706;
	Wed, 19 Nov 2025 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763572832; cv=none; b=p/6duOw3uPc6+zjQAewYR4kOh82Wvz+8pAOGjMvhC3u2lUvdA4dSd6vqyWaj85f8IU4k1b2XTuo9UBtc0/nfaQpRlXGdgMU/lExGcSgtCan+dbj8fTNI+u54XTjRhdpERdlaByuhLj4dOw9sSvkuzYlac3GSFdiWPEqUz7Cx5NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763572832; c=relaxed/simple;
	bh=jbVSjkm6B2TIhYElL03L/ogME2sV6mZYyxeksySfKTE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CAiGSCJsNCBRNa5agfDLMBWVRLdUEsLlABAqo9ppSK3vfjT+KaDeC+HPBGNtClXB6wFu4WmV+E3vxg4gqF/lWa94a+PQz3D8MWPH0uc85rytXtLJXw4WIElawA87+kO5N8funhR5qCM+XSD6CZdSLeCLBBoG4v60AkiThOkHi8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MmGg7LNf; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 008991A1BEB;
	Wed, 19 Nov 2025 17:20:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C0A4460699;
	Wed, 19 Nov 2025 17:20:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2EF0810371BA3;
	Wed, 19 Nov 2025 18:20:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763572826; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=jbVSjkm6B2TIhYElL03L/ogME2sV6mZYyxeksySfKTE=;
	b=MmGg7LNfCTZaN2J1aReUQyberrBbp5/Zr3km52Fs1kL7rUCVVKuIp4QuzgqOHf2uA0MM0p
	UjV5dhrGXhstPFS64zL7U9v90yaoJ0AsSut1pd94su+7XV0s4WtkefDhWeBm6D2bTOMyaz
	uhSuhSBdIQ69tmNmQF1/rXZAF3dw9PBOR35OJ5TuO2gB0YOK8kAMY9PqXqISR6rkbikJf5
	R39yxjf4d8Xqs8KN0GI2WeXr0Pu4Lnj0+7pDa93xJfiMBPabmfw38PXUDBWMQrOv0m9A9U
	f+tRUNhqyjU7w4cLUP3guIa2WQVAjj1q13zk6lqJaDnIC4iQ9QYbP+sIWpmrMg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Mark Brown <broonie@kernel.org>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  Steam Lin <STLin2@winbond.com>,  Santhosh Kumar K <s-k6@ti.com>,
  linux-spi@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org
Subject: Re: [PATCH 07/28] mtd: spinand: Use standard return values
In-Reply-To: <a852781a-70e1-4da3-a283-a81be10daac5@linaro.org> (Tudor
	Ambarus's message of "Wed, 5 Nov 2025 17:06:44 +0100")
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
	<20251031-winbond-v6-17-rc1-oddr-v1-7-be42de23ebf1@bootlin.com>
	<a852781a-70e1-4da3-a283-a81be10daac5@linaro.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 19 Nov 2025 18:20:24 +0100
Message-ID: <87pl9eaqhz.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 05/11/2025 at 17:06:44 +01, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:

> On 10/31/25 6:26 PM, Miquel Raynal wrote:
>> Replace -ENOTSUP
>
> do you care to fix all mtd? :)

Call myself lazy :) I preferred to fix the return codes before adding
another path, otherwise I'd have had to add yet another ENOTSUP value,
which felt wrong-er!

> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

