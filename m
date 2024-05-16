Return-Path: <linux-spi+bounces-2865-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE368C76FB
	for <lists+linux-spi@lfdr.de>; Thu, 16 May 2024 14:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07B831C212FA
	for <lists+linux-spi@lfdr.de>; Thu, 16 May 2024 12:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A39414658E;
	Thu, 16 May 2024 12:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eSpQPfoi"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870331465A3;
	Thu, 16 May 2024 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715864366; cv=none; b=enr9IAWOs2rO6k9XEEnf9htPbvFeCb4dTrisQh4oUibwhHH/kSPsnpi83u5fTKI5xMh8ccwxJjeCKe4S/gQZkeHcabmsauPCCM6MW8339Sky6MHoUBBRyKU4T36cm1UOmsswZEjAREpRZqt3ceDPSYcbIXDrXpw+nx8d6Snwesk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715864366; c=relaxed/simple;
	bh=fkbF/End0NfH0vDRgzXTcR2wXK/pS42MDmxTNCIwusA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VIfZ6OuH78uGRc4Ydl5IQ+77G4R2PZvyWPB7ihEPyedy7iysI0aIU3/fO/3ZWutBwQpX3U2IvOWSIi56iGxU9ab1jWNm/tPDR4KdozjHuyOyhZiWbWc5pw4nJiR8Rm+udDoqoGcwJlrdKA5nxn+ohJ+CUNoIFPNGo9xpFHR9VXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eSpQPfoi; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B4A0D1C0013;
	Thu, 16 May 2024 12:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715864356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6VYt2HYh+V2OT/jwfpv8GJca1w+iP1kom40uemwth2I=;
	b=eSpQPfoiWXLiVFtiq3Xw9nPRgPt7/bOkaNUviPXkYgdAaJfNYA4i2lMvpKUVqI9GNbrcyA
	3txJ31lbVOne2gRmvLo63GQap7QwRZGPyUUMO2hpa/tfZuK8IHcGRuzVkka9wvyjKMLyuN
	Y64Bue0PtnjoiTqf6SSnuwa9WKNYvFBS6iTMthTI0/kZrtBnUTCUSXs6G4eUztQ/egioeg
	rqCea/g4I7C+bubDhyEh6HBe6w3YwlevvdnpvnohBjhRTVAvqWQ/0RS9acHfN2HgdE66Bl
	qzDE/a2e7LFjt/DLnsM0QUprgHhb4qnaBLcKIbFbm9BAwarf6K75fBylurYl7w==
Date: Thu, 16 May 2024 14:59:15 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
 richard@nod.at, vigneshr@ti.com, manivannan.sadhasivam@linaro.org,
 linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, quic_srichara@quicinc.com,
 quic_varada@quicinc.com, Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: Re: [PATCH v5 7/7] arm64: dts: qcom: ipq9574: Disable eMMC node
Message-ID: <20240516145915.10adca29@xps-13>
In-Reply-To: <20240508083637.3744003-8-quic_mdalam@quicinc.com>
References: <20240508083637.3744003-1-quic_mdalam@quicinc.com>
	<20240508083637.3744003-8-quic_mdalam@quicinc.com>
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

quic_mdalam@quicinc.com wrote on Wed,  8 May 2024 14:06:37 +0530:

> Disable eMMC node

Please explain why or remove this patch from this series, because at a
first glance there is no reason to link this patch with the others.

Thanks,
Miqu=C3=A8l

