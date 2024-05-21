Return-Path: <linux-spi+bounces-2983-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E37248CAE9F
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2024 14:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A07F8284C1F
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2024 12:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6214F770E4;
	Tue, 21 May 2024 12:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NxecRWZ9"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73131E48B;
	Tue, 21 May 2024 12:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716296016; cv=none; b=m/p5qppq0UG/yaWVPzDZWNLdbSJO5Mj+1GeL9+R0cD1I0wGVZt8sr5i1RmFnd7CjbHdqY/oaJUoj9mpqEmNikann/ubVUw1dcRoNxP9MT9HCzrAZ+nq4UbY6IujazdxdBRCTURxMK/JIhFlxsJF+nHuKd/dXJw8LoL7jfZN49Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716296016; c=relaxed/simple;
	bh=lgDiOgPFq8VFi3B4aIXbFrjhcBMxVHtHlXhQpFMcXhU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z/LZwOsVPYYOnP1t268PRAoyV/cwzn62DCuSfh2TcUROxvzZrbA9T72qIcsDnsr6GeIyBJ1P+K0DOKOxFqhQqjNoDhVqejXXRyOSRQIPzLDYtZ6PT7n1LV6yMW0fxjPtcB/6mP257WQXH7SlMBejYSHCM5SZT33DQKZDAuHvgs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NxecRWZ9; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5F7FE2000F;
	Tue, 21 May 2024 12:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716296012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lgDiOgPFq8VFi3B4aIXbFrjhcBMxVHtHlXhQpFMcXhU=;
	b=NxecRWZ90FMduVzjE8WaLnyMzssesC41tfBRcOF3bxHW+6C0AwIS1e+GrufILjbKDVdBT7
	fD3QWNVhis1s/9ok7VGH5A3TulZdgYHtQkp23PpSGV4bGviVmi0l8ur+2WjzF3h+q9aDaY
	9LvwWQGVIPQn6mHgi883Xq0Pn2ENocGZDc/dgKfBE44z8G9Jp32l8Mn6RXxtxXWpZs8uHy
	LKw6yohy6QxNwnpwGPgwx0BMvGDG5/PTLRF24mPJCnu5jnfqor9T2fKwVAtJ2n/0zZ/JiC
	gBG3OGw13uPoSy8wOyEvMm3Uk19NHOSPvhaE9BOZp4Tu6TY4/5ppK1Jgw83v1g==
Date: Tue, 21 May 2024 14:53:27 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
 richard@nod.at, vigneshr@ti.com, manivannan.sadhasivam@linaro.org,
 linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, quic_srichara@quicinc.com,
 quic_varada@quicinc.com
Subject: Re: [PATCH v6 5/8] drivers: mtd: nand: use FIELD_PREP and GENMASK
Message-ID: <20240521145327.745f8b50@xps-13>
In-Reply-To: <20240521105532.1537845-6-quic_mdalam@quicinc.com>
References: <20240521105532.1537845-1-quic_mdalam@quicinc.com>
	<20240521105532.1537845-6-quic_mdalam@quicinc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi,

quic_mdalam@quicinc.com wrote on Tue, 21 May 2024 16:25:29 +0530:

> Use the bitfield macro FIELD_PREP, and GENMASK to
> do the shift and mask in one go. This makes the code
> more readable.
>=20
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
> Change in [v6]
>=20
> * Added FIELD_PREP() and GENMASK() macro

Maybe you want to include linux/bitfield.h now.

Otherwise that's a great improvement.

Thanks,
Miqu=C3=A8l

