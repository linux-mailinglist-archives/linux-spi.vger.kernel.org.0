Return-Path: <linux-spi+bounces-4988-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1D8986F54
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 10:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AF4D1C2177D
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 08:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F471A704E;
	Thu, 26 Sep 2024 08:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Dkkvc5ud"
X-Original-To: linux-spi@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B1D1A4E96;
	Thu, 26 Sep 2024 08:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727340780; cv=none; b=krgkDpByQOFrlgqS5p3QWwWz9k7TO2BcFTYaYWNFGRuB/oHS8ZmwWNakYZrCybybPbjeEJj4p2FcKAdKotQcdD36uwgPq26F4EhmRogoF2Q3SsBmNtnpzLP1T48Rfcc++aAiwcJA6ja58Ks1EsibR+OlcJJc5A9ikEJHrqzkmCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727340780; c=relaxed/simple;
	bh=xVPEuJ0U3Vx4ark3kH665s7RklcMjw8TvbrNnMIFg8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O89pN7TE60nx1M6UTzDTHTT0DHF/s1YMwWcQIJvbsh8GTcgcVCatACS5cyGUFzIAiEQfajneL065fk9q71LZnXGC3iNMLpm/ZfElbBOMtn2gQ8n4cpfbZT8uV1V8fbQ4LZaUYRjl2kLfkQr8BXeEZpOkr6ND20fMA5sR5UlyrP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Dkkvc5ud; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fd5BXslH/t6O1o9B8qLu7CipOnWPeHEzCvLu9CNlv7Y=; b=Dkkvc5udY4QTsSbOqbBk1kWCN4
	qLEXRuY32P5bcNs5PCO1M6EwQR3z2/ryo2S+bZfTQ5EKiOiOdX77Kcf41DoF/G0pKukoNIIKN0ro2
	6TjeYYB5tqJWNOCTT1OMOcEW4I6KPrzeCZXhQo+JGO1nsxpqcmyVByoCBHZKzY1pr6AD+k8SdUqRN
	0ry0IXxMVc737Rpf6V2aI3QAtGI8FZW100cS9YksBfsEFc7VUooPsGI2CTMN353e3BrkmLCVMomN0
	O/Ao8c4YdQzNb8je5Q1yUJdp7W5sKs1CoXiPqFv7y36REWk7TMN5991HfMbi1V6mJBMhKIxq3iFFC
	X9U73pqA==;
Received: from 85-160-70-253.reb.o2.cz ([85.160.70.253] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1stkF0-0001pZ-Fk; Thu, 26 Sep 2024 10:52:50 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Dragan Simic <dsimic@manjaro.org>
Cc: broonie@kernel.org, oss@helene.moe, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] spi: rockchip: Perform trivial code cleanups
Date: Thu, 26 Sep 2024 10:52:49 +0200
Message-ID: <6085918.31tnzDBltd@phil>
In-Reply-To:
 <663ec6bb472ab83bb5824a09d11b36ef20a43fc7.1727337732.git.dsimic@manjaro.org>
References:
 <cover.1727337732.git.dsimic@manjaro.org>
 <663ec6bb472ab83bb5824a09d11b36ef20a43fc7.1727337732.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag, 26. September 2024, 10:38:12 CEST schrieb Dragan Simic:
> Perform a few trivial code cleanups, to obey the reverse Christmas tree rule,
> to avoid unnecessary line wrapping by using the 100-column width better, to
> actually obey the 100-column width in one case, and to make the way a couple
> of wrapped function arguments are indented a bit more readable.
> 
> No intended functional changes are introduced by these code cleanups.
> 
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



