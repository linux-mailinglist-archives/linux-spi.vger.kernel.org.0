Return-Path: <linux-spi+bounces-5234-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6400999F12E
	for <lists+linux-spi@lfdr.de>; Tue, 15 Oct 2024 17:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7631B21C60
	for <lists+linux-spi@lfdr.de>; Tue, 15 Oct 2024 15:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591F51D5144;
	Tue, 15 Oct 2024 15:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Yf1ljXfe"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AA81B393B;
	Tue, 15 Oct 2024 15:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006202; cv=none; b=UmCVSrzaTbMCSIarPTcia8NvnpqNb/N41IL1YGB0+rnsJ2m9en/9EMheBBeqPxLPf8xslGDOEqCtKWLyzAOlsrpEM4y0sgO6VQa9Ry6s0+bpzrFDcjaUpFCHGW1scAwfMtsANJbXl1V+Yy1wS/PxQkSVcPNZ//FLMvkzY/cISX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006202; c=relaxed/simple;
	bh=HaVhpW7Ics2MRpfn0xGZsAZUvpMCJ3l4z2GpRV7dQ74=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E4/5HH/R5+h4i4bz1dV3fKiaGl7oSAzuOF1AT24IZAu1yFih+/O7+r3Dm46DYkjCEgUyQjBTnBMiEKIKdqyN1KBgi5r8PvTEPchzUXPICM9h4QsvzG7Snm7UWkcYBq6UYJGsx4zG0ahRyFWdHih+4nltROCoD0xA67GOKLbvmKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Yf1ljXfe; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5CDE160004;
	Tue, 15 Oct 2024 15:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729006198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HaVhpW7Ics2MRpfn0xGZsAZUvpMCJ3l4z2GpRV7dQ74=;
	b=Yf1ljXfeEYOrQbZx7F6IwVqbfvTTbBstPv4H2/qmM1PHWssqib5iQVIZD2yh11Jsh+0roP
	5G544rVm5sTzrTjqyLZTy6W3fljWi6MQ4M/a+m/xDlEMmZDuYdF3Xpx5XdBVQJdUbj5yld
	tVfzh5ret3VHVpQopQ5EMYpC+oYkiBUeqXOAdVDDLXfppGC8AETuJBCNasQeSKedgHJ+/k
	KrVGlmm3fu7GZBzcNXPZkzmmUGGNVt3vTE3i7bP4zBLLJ5XtKys5UdXOGxOFUPbRxeir55
	9MXruQO2R34Zb11RN8L+xtvBeGCM8Vcq27LWzJsfz6GDEdIi9fYb0rfzlJtGFA==
Date: Tue, 15 Oct 2024 17:29:55 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: kernel test robot <lkp@intel.com>
Cc: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org, richard@nod.at,
 vigneshr@ti.com, manivannan.sadhasivam@linaro.org, arnd@arndb.de,
 esben@geanix.com, nikita.shubin@maquefel.me, linux-arm-msm@vger.kernel.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 oe-kbuild-all@lists.linux.dev, quic_srichara@quicinc.com,
 quic_varada@quicinc.com
Subject: Re: [PATCH v11 4/8] mtd: nand: Add qpic_common API file
Message-ID: <20241015172955.7b0b6708@xps-13>
In-Reply-To: <202410130129.M8J7VJoG-lkp@intel.com>
References: <20241010070510.1504250-5-quic_mdalam@quicinc.com>
	<202410130129.M8J7VJoG-lkp@intel.com>
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

lkp@intel.com wrote on Sun, 13 Oct 2024 01:57:12 +0800:

> Hi Md,
>=20
> kernel test robot noticed the following build errors:

The below errors seem like basic Kconfig misconfiguration. To be clear,
I usually don't review series getting kernel test robot failures and I
am expecting that you will fix these errors and post an updated version.

Thanks,
Miqu=C3=A8l

