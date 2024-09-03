Return-Path: <linux-spi+bounces-4527-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11512969EB5
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2024 15:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86A23B238BB
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2024 13:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6949C1A724E;
	Tue,  3 Sep 2024 13:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IXZPo+KT"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89F31A0BC6;
	Tue,  3 Sep 2024 13:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725368922; cv=none; b=swfl+sUsjpKbtTMvdculGmkhZSd7A/U25L745+Pm3VLo+aFkmtS24S4C3rgWlRaXyR/sTSaXgpDSYu2X0tfN1x1ZSEWpUiOntlb7llPci9MLFeGPotlqXlMzzWSKGCmPwo67qo2GwXpAvRukhhvd9SiDm72scSPkkQHcIxVuw34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725368922; c=relaxed/simple;
	bh=clzfDAUKNaEKJTxWQo3EO3dRZsqSu3Cc9NoGkCzcJkM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Znl5Ggk4B+sGvrOiUboCcYdznE2n//a/+sX72dYO1owiX18wvDD7gZwOSd8mYlQP0cJ16rJmd/LmA5p7qz4R/UeX0kKHWj7nzHgnGCHbECpol3B+ju145weDW/Us/WF8wI5HrOFiBk2YB37h1zb8DoHQRIgJzbEgz/RrcKQL6p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IXZPo+KT; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E1F111C0006;
	Tue,  3 Sep 2024 13:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725368912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7pB2vNbOkOQHLpYZQbbZDQTzWnUnjZRAGf+Nhk5QM0w=;
	b=IXZPo+KTvxrtzSiz3SiL1HOa5CNDzdKsNQQizKxXRTvvVJXiXtFUwnYvyg09JY3mz65lf/
	1stZz1eLHmN0hskkocyekJfFkLdYbWHaf0FTqL7L0NCMaWc8Cc3wrELDxAbpJgmFKz9sEp
	uM+cUAdlkG5yLsEnbr8oDEZmePRVBO3rVWOntYy/wQvHRFsW7EmZByiGHJXN5C9jX5y601
	6/byMAzy+PbQfXBVQCCU7qbEA5KryZZfm1yiaUAQthly/FsvvhprBDl9/kDhDxAByPhHAN
	G00VPk1wiDOdSNlis1OuAUb8J3BqwJTd5RBY1xqp4Mr6PDNzXZwcVlHiVuASbw==
Date: Tue, 3 Sep 2024 15:08:26 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
 <richard@nod.at>, <vigneshr@ti.com>, <manivannan.sadhasivam@linaro.org>,
 <esben@geanix.com>, <linux-arm-msm@vger.kernel.org>,
 <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v8 0/8] Add QPIC SPI NAND driver
Message-ID: <20240903150826.749b8560@xps-13>
In-Reply-To: <5169761b-422d-70ab-ba53-a898cb7bfa2f@quicinc.com>
References: <20240820104239.1774600-1-quic_mdalam@quicinc.com>
	<5169761b-422d-70ab-ba53-a898cb7bfa2f@quicinc.com>
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

quic_mdalam@quicinc.com wrote on Tue, 3 Sep 2024 14:45:15 +0530:

> Hi Miquel,
>=20
> On 8/20/2024 4:12 PM, Md Sadre Alam wrote:
> > v8:
> >   * Fixed compilation warning reported by kernel test robot
> >   * Added "chip" description in nandc_set_read_loc_first()
> >   * Added "chip" description" in nandc_set_read_loc_last()
> >   * Changed data type of read_location0, read_location1,
> >     read_location2, read_location3, addr0, addr1, cmd, cfg0,
> >     cfg1, ecc_bch_cfg, ecc_buf_cfg, clrflashstatus, clrreadstatus,
> >     orig_cmd1, orig_vld to __le32 to fix compilation warning.
> >   * Included bitfield.h header file in spi-qpic-snand.c to
> >     fix compilation warning
> >   * Removed unused variable "steps" variable from
> >     qcom_spi_ecc_init_ctx_pipelined()
> >  =20
>      I have addressed your comments to v6 and further posted till v8.
>      Could you please let me know if this is fine.
>      and how to get this merged ?

There are still kernel test robot reports, so this means there are
issues in your code that I don't need to point out explicitly, but I am
actively waiting for them to be fixed.

Thanks,
Miqu=C3=A8l

