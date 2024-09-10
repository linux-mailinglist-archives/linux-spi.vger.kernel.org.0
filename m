Return-Path: <linux-spi+bounces-4763-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10050972B03
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 09:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 427D71C21EB9
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 07:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BAC1802A8;
	Tue, 10 Sep 2024 07:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KXVpYS7Z"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B7C17E8EA;
	Tue, 10 Sep 2024 07:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725954089; cv=none; b=kpP8LNkWOPOr55BKHE7RJlDjqo45SZGBp/Sbbx4f39SP+KTu+33Ktsn13iaLdbjjR6O3gBFZcsXquxFrDdqM5nBEDIR28FdejZB8egtc2jbUZ5V+uxhFtbPRIKspXiXaNyJJw/m/5MKogapOTMTKjgvpLPbT+a/qWm+6nRl+ULo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725954089; c=relaxed/simple;
	bh=0I1CyWm23D97I4eXjHRqIKBJl40TlwGc17YBFqRaG4g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nosG3/k/jDL5j7w1HqDmy1aVyFC9gTaRoADzw2a+DASHacwe+Vut9lcXzmLlKKIsbwERz7gS2GTLClSxNi+t/GmZH/JhZyq+ntatYwJfmohhRPJtYO0f4nVMyrR1Ss9AWegkZ+b5UXeEfCB3gwMwPY1Os6OLO9FzYou8SfLKiUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KXVpYS7Z; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2E6D9FF80C;
	Tue, 10 Sep 2024 07:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725954083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=af5m1sT62PlbZm1pnjn+q6UsEmjHIWOgLofQJKFpyhE=;
	b=KXVpYS7ZX2ePDbG+y3lo9eckSGGfA548IHJNPUXZGhUOZb2sgUBHTeHO4+5uTbB1AuXwHY
	Xr9/3WnHY6310FIbWrgpVZ/fBUeL5rj71mvsXN08h0VGmVP5JVr09PnunH0SGwhPsLw31P
	OOiOgOLi+r1l02asILsOSoeOKMFVXmLOqrAzxBXYpsDP0Tk9AdEb8wsATx4Xd/+2FoKCDi
	zpyxa78EdvVQSG/ILI8y6m6hJnPJdxnkJQPudLjaxnlN6mlIyerOgVe7ovKpGzwC8pgfb5
	IW09mctNs2rYqw2tD/JjuFKJ8xszlIR6/ZKcKQTLt3UcO4nWm+WvCJuGisR8yg==
Date: Tue, 10 Sep 2024 09:41:20 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
 <richard@nod.at>, <vigneshr@ti.com>, <manivannan.sadhasivam@linaro.org>,
 <esben@geanix.com>, <linux-arm-msm@vger.kernel.org>,
 <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v8 0/8] Add QPIC SPI NAND driver
Message-ID: <20240910094120.19348fea@xps-13>
In-Reply-To: <bb1397c3-2327-e211-f7eb-cac4b126424e@quicinc.com>
References: <20240820104239.1774600-1-quic_mdalam@quicinc.com>
	<5169761b-422d-70ab-ba53-a898cb7bfa2f@quicinc.com>
	<20240903150826.749b8560@xps-13>
	<bb1397c3-2327-e211-f7eb-cac4b126424e@quicinc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
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

> >>>    >>       I have addressed your comments to v6 and further posted t=
ill v8. =20
> >>       Could you please let me know if this is fine.
> >>       and how to get this merged ? =20
> >=20
> > There are still kernel test robot reports, so this means there are
> > issues in your code that I don't need to point out explicitly, but I am
> > actively waiting for them to be fixed. =20
>=20
> I have fixed most of the sparse warnings after converting __le32 to u32.
> However am not able to address the following sparse warnings
>=20
> 	drivers/mtd/nand/raw/qcom_nandc.c:1401:29: sparse: warning: cast to rest=
ricted __le32
> 	drivers/mtd/nand/raw/qcom_nandc.c:1587:30: sparse: warning: cast to rest=
ricted __le32
> 	drivers/mtd/nand/raw/qcom_nandc.c:1588:31: sparse: warning: cast to rest=
ricted __le32
> 	drivers/mtd/nand/raw/qcom_nandc.c:1589:34: sparse: warning: cast to rest=
ricted __le32
> 	drivers/mtd/nand/raw/qcom_nandc.c:2479:47: sparse:    got restricted __l=
e32 [usertype]
> 	drivers/mtd/nand/raw/qcom_nandc.c:2480:47: sparse:    got restricted __l=
e32 [usertype]
> 	drivers/mtd/nand/raw/qcom_nandc.c:2616:25: sparse: warning: cast to rest=
ricted __le32
> 	drivers/mtd/nand/raw/qcom_nandc.c:2672:32: sparse: warning: cast to rest=
ricted __le32

The rule is: you cannot add new warnings.

For existing warnings in the driver, I'd anyway advise to solve them.
Without the actual code I cannot help.

Thanks,
Miqu=C3=A8l

