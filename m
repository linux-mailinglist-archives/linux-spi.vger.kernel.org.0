Return-Path: <linux-spi+bounces-4141-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F4D947B93
	for <lists+linux-spi@lfdr.de>; Mon,  5 Aug 2024 15:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A3B328388C
	for <lists+linux-spi@lfdr.de>; Mon,  5 Aug 2024 13:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB9615746B;
	Mon,  5 Aug 2024 13:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=angelogioacchino.delregno@collabora.com header.b="jhZjNKYz"
X-Original-To: linux-spi@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4E51E49F;
	Mon,  5 Aug 2024 13:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722863398; cv=pass; b=JRFHSsBC8jnZfxD6Nn0wOx94MNWASPPLjgy7+leawyWU3CmkXiYCEavPws+GdSAq8MHswRtjrzBgnwVWfUdyLbSV09DY87PtSZTLgNW87yaCPMoVgV8mEatdJwQC09JKDgzWTaDlcPReBH5P1FMOBb9nTLaXi3fNtDgl2/Jg9uU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722863398; c=relaxed/simple;
	bh=2iJ4oaMx1nMAjInyxQQK66ZqyHcRAVQyXrsRCb17lW8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t3Mm3Y8+apx60WuohXvbfvTsoHZ6j/3VesKIT1X3SgM4RjtAVJVTxVy9S7Gfs6ckJB6weMQ7CQWP1DcR5nasywh+ifekjJ0huqcG+GWphq2goodPgZmmnvvzY/cCieLivNeg01kurhB7EFzlVvf3RW1/5W1jocnQq6L9p9fRit8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=angelogioacchino.delregno@collabora.com header.b=jhZjNKYz; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1722863372; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=E/+z2c/rbcBMKfwFkjoxLcGsAmpp2sifRxR2aZzmQt7TybbcxmC7osGbZG9Mx2UKSMx6Xrd5zbphSDvwKE4L0w7KoyfpjCMBhVDFd8yHHxxGGcOHRNg4ziT0y9/Lne9DsGioWX8eQ4956HtFQZGCpgs9mz7RmWgHLdA6UXOjl+U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1722863372; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VQdZwOVeHf7udvthWkMPGVSKsH0hrajNPr+Zg+3h0zc=; 
	b=QmNUuM/E63RgQV8j7SD/TwNHzlTePvdQxi9xH5W+e5RI88rCR0Q2ChhqDyRq8xv85+LiVAOF+ppA/EVEm68kLp/X3h2WwSwr04Kqdc1bDOmK0krHTfif7DUq3YKhSGg1HqAwZ3xvDD5FudJHdtViXRU//RcRMtWkIb2aBqTqr8g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=angelogioacchino.delregno@collabora.com;
	dmarc=pass header.from=<angelogioacchino.delregno@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1722863372;
	s=zohomail; d=collabora.com;
	i=angelogioacchino.delregno@collabora.com;
	h=From:From:To:To:Cc:Cc:In-Reply-To:References:Subject:Subject:Message-Id:Message-Id:Date:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
	bh=VQdZwOVeHf7udvthWkMPGVSKsH0hrajNPr+Zg+3h0zc=;
	b=jhZjNKYzskUl5AR2tRoOrGFrPG0ufWPv8VdswbSResCliIZTlJDQF6usyr65LA5D
	BxKt7OG6xyNVmecST78Ux/HhgXWM3FPikzTzJya/FDOKKm2RD6ythrQfHRNmYOjNT4d
	FE7KGbSE7BnTK4L+7UI6v1P11IHX1NfBoIUCPG2o=
Received: by mx.zohomail.com with SMTPS id 1722863370677901.5009092360644;
	Mon, 5 Aug 2024 06:09:30 -0700 (PDT)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: Leilk Liu <leilk.liu@mediatek.com>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, John Crispin <john@phrozen.org>, 
 Daniel Golle <daniel@makrotopia.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
In-Reply-To: <20240727114828.29558-1-zajec5@gmail.com>
References: <20240727114828.29558-1-zajec5@gmail.com>
Subject: Re: (subset) [PATCH 1/2] dt-bindings: spi: mediatek,spi-mt65xx:
 add compatible for MT7981
Message-Id: <172286336774.159349.11641344023226558770.b4-ty@collabora.com>
Date: Mon, 05 Aug 2024 15:09:27 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0
X-ZohoMailClient: External

On Sat, 27 Jul 2024 13:48:27 +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> MT7981 has SPI controllers based on IPM design
> 
> 

Applied to v6.11-next/dts64, thanks!

[2/2] arm64: dts: mediatek: mt7981: add SPI controllers
      commit: 64b1cbad62cb11ab25ef87ed71561bad92ab93e2

Cheers,
Angelo



