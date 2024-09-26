Return-Path: <linux-spi+bounces-4992-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C08F986F7A
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 11:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50ABD1C23DB6
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 09:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCE8142E6F;
	Thu, 26 Sep 2024 09:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Scbyxt2W"
X-Original-To: linux-spi@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FD914F114;
	Thu, 26 Sep 2024 09:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727341315; cv=none; b=sIGdofJ27asDwlSdbBdyZNdV7i0NDqIm24RikjUPH/PbYQlC3Ne0M9MVYIDK2MkLLB/XilS4O32K7ebVkzT87Xm3x/JBh1QYpWdiR7lCFRtUtDpIEOJUfSWW5djgN0EddtNWQuGcHYM1PCEK8J7y1/S6ypmySzyXV/sbRtAytTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727341315; c=relaxed/simple;
	bh=SUDkknmyCMG4lDxUIzfSgRkWysqlfqxQ4yrKZv1y6OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uihUF9FG+IKNDwkiZdIrnaO0yg8F/WpcRnVOsi7pL4XcWu/pCwTNE3GYXWdJ6Dpu9SAjHDfyGEgC9PF+ZiuBhvF3HA1dXgpU2MswbhBW/5lmqxjeYku0WBD2+APrGTjsdZEx6aR3AT2pOnjPYvKpqx5MnNUNFHSnbKEabyY0gP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Scbyxt2W; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Og2E4NsExqm80Fx/6/kY2swjPZej27nRPCpYxgOFAw4=; b=Scbyxt2W18lGs+VCm0grlzNFbE
	xk0ar8UYu8D5nqqIiTgK8605ksY+s4ea3kcJOITeInYeLbsa5h/c2kuxloZS5RQo3N2eCdgjEdoGF
	AXqyxaXcnlQNIj61GbypSf5mrtBPeHjVW3bSefXNcdJdbgXhXyMQkwYXZwuS1pPouYqer2C5jPldP
	Ccjak1xQrvAbwU6sPNBDb9JRkx1sOG56kMsMyoz63ZYeS0ygP8pAzOrjfMvMLOvKogd5SUCSxMyEK
	bnPoxYaPVkONyN98hNI3pJjgxasc26Rm1DrzKsHIkQNLV1TAQs8v1SAsKPLQJO0xb/XmxtVTAhSqm
	a5NPjT+w==;
Received: from 85-160-70-253.reb.o2.cz ([85.160.70.253] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1stkNi-0001tg-3j; Thu, 26 Sep 2024 11:01:50 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Dragan Simic <dsimic@manjaro.org>
Cc: broonie@kernel.org, oss@helene.moe, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 5/5] spi: rockchip-sfc: Use dev_err_probe() in the probe path
Date: Thu, 26 Sep 2024 11:01:49 +0200
Message-ID: <10409403.0AQdONaE2F@phil>
In-Reply-To:
 <8f65c1ec7737af7f2a538fcae3618756a53ba3fa.1727337732.git.dsimic@manjaro.org>
References:
 <cover.1727337732.git.dsimic@manjaro.org>
 <8f65c1ec7737af7f2a538fcae3618756a53ba3fa.1727337732.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag, 26. September 2024, 10:38:16 CEST schrieb Dragan Simic:
> Use function dev_err_probe() in the probe path instead of dev_err() where
> appropriate, to make the code a bit more uniform and compact.
> 
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



