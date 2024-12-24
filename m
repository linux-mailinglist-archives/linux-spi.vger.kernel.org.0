Return-Path: <linux-spi+bounces-6158-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5BA9FBFBF
	for <lists+linux-spi@lfdr.de>; Tue, 24 Dec 2024 16:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E101885237
	for <lists+linux-spi@lfdr.de>; Tue, 24 Dec 2024 15:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA7C1D6DCC;
	Tue, 24 Dec 2024 15:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OrEn7nQg"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071981BC3C;
	Tue, 24 Dec 2024 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735055014; cv=none; b=uKB8fRygyfOQsXRhbRdeOLTKhKXFjGGUqVGepNeh+JmMUcEfdga9QK/CTkJBwrtptRaxXDXeqKv6OCvOQKYzA9T5UDpJarIdAosGRIA21N91zTCKrwDlaXTEAhdBWuJ6Zr6b3ztCB1gbgZIJyiX/ztThR4xjpGkNgX4NIkj8Be8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735055014; c=relaxed/simple;
	bh=brtdJK4WKkKlESa9dLmKrsWKvafiFE2osEZSwV9IkvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uv8nhJzc/CHE6w21lOISYBWMHDHB/AoyT0p3mf912G4YlqXEhnMQ2iDADZMvF+/XdUx9a8m55X/mVK//RNWyoRgWRNFkJQjLRlIwGgfrF0J56HmKPIpVDsDr4DocVXVU5NotBpnDd59zD5tHSpwIk2PTb+uHbGMFADRV9/gFenQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OrEn7nQg; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F2142C0006;
	Tue, 24 Dec 2024 15:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735055009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F3+hSGSHlH4/HIta8u7/GmGd5FBLxZS+Wb7ky8FWtyA=;
	b=OrEn7nQgApH+CtWryuRC0bwTkZtS7shbgt785gNv6ZkgfXEEYOoNDwvsXOUW0O/VsaSfAZ
	lHvqD1/SJPs6MUNhixLLi3U9PFLyobotPW10cWUSzWRj01jOqZGEy3xJuNPrj/R4R9y00V
	ifHkpIPl3+2hqH3aKo/kQblWM1CGddEx+dOh6OuWau568uicZc4fDlIAIkZ/eAQhjk738b
	QDsb//lZsRkUpL9TC8q2cyHJab1rc+4zkQVrWtnRF+cTsLue/QTQm3Bgw6bzFfjZ1M1+ov
	23s9ufGXw53gP3vtBbOxReoHj00yMtlkKSMCndJYNmBEatJYjAFD/xSL3DBWVw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org,
	richard@nod.at,
	vigneshr@ti.com,
	manivannan.sadhasivam@linaro.org,
	linux-arm-msm@vger.kernel.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	quic_srichara@quicinc.com,
	quic_varada@quicinc.com
Subject: Re: [PATCH v14 0/8] Add QPIC SPI NAND driver
Date: Tue, 24 Dec 2024 16:43:21 +0100
Message-ID: <173505491734.10614.11394326797380035834.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241120091507.1404368-1-quic_mdalam@quicinc.com>
References: <20241120091507.1404368-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Wed, 20 Nov 2024 14:44:58 +0530, Md Sadre Alam wrote:
> v14:
>  * Updated commit message
>  * Fix spelling mistake
>  * Remove "inline" from multiple APIs from qcom_nandc.c file
>  * Move '|' in qcom_param_page_type_exec() APIs at the end of line
> 
> [...]

Applied to mtd/6.13-rc1/qcom-reorg-for-spi-6.14, thanks!

[2/8] mtd: rawnand: qcom: cleanup qcom_nandc driver
      commit: 8c52932da5e6756fa66f52f0720da283fba13aa6
[3/8] mtd: rawnand: qcom: Add qcom prefix to common api
      commit: 1d479f5b345e0c3650fec4dddeef9fc6fab30c8b
[4/8] mtd: nand: Add qpic_common API file
      commit: fdf3ee5c6e5278dab4f60b998b47ed2d510bf80f
[5/8] mtd: rawnand: qcom: use FIELD_PREP and GENMASK
      commit: 0c08080fd71cd5dd59643104b39d3c89d793ab3c

Patche(s) will be available within hours on linux-mtd.

Kind regards,
Miquèl

