Return-Path: <linux-spi+bounces-4248-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F3A958544
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2024 12:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDEBF1F284C6
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2024 10:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88959188CB3;
	Tue, 20 Aug 2024 10:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2m5dmWy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6520A18E375
	for <linux-spi@vger.kernel.org>; Tue, 20 Aug 2024 10:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724151397; cv=none; b=W4MFNpg/l4nDdVIwnX0NeB7tdpKjLjsrVmzsUqAYn0f+JsOBvDyqepCTFLasQMsVMoK4x1iTtkMy2bEGYBoYHbYEAUqLwog2YrQI1ztaqaVF1LwieStCL5EvNsRXvS5N7fjgAbfPJZpc8wpSz9kComD6aba8Mq2ihoeos6uciM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724151397; c=relaxed/simple;
	bh=RLxhoFZaBlNOXT32HBRBSDKbgugg7gvw3Dt99ZZNweE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=h1nQHA0FITZiSKTcm/tBfwXez/q3DyjrVW09/i4y0RsZuJDd444CYgQijgo8RTpPILjMWa5K++tx5BuRS893l1s6g2FeGRQp1AximZjDFXSUuId5rIRrFq+zbU65QEDTI4Pri1LPf60dsxECKu5Hk1tlIrV8Q6zlvIB71emiiN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2m5dmWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F005FC4AF0F;
	Tue, 20 Aug 2024 10:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724151397;
	bh=RLxhoFZaBlNOXT32HBRBSDKbgugg7gvw3Dt99ZZNweE=;
	h=Subject:From:Date:To:From;
	b=b2m5dmWyOb1V9+Rz7ZKc7QvtvgDuNxboWvpkOInagLIY8fLoyPdtrW85wduw+Pm0e
	 ijzKV97CETZBxwnhD1e1ROJ6BvIGaqQn6VwKGldLmMywxSLSIG0Kqcb+sz7O8j5zv5
	 4tWhDflWwUawtR5jz7wJi/vmZWWOsjCpAySc4nPT7f/9GpUuw8kQX8T9xm7akNSxlL
	 3Ho7yXSgaOOIYx1KG9Hep2mU6YHTEX25z5NiICXdMmkO+eIrydVi2vxkdquxORLTLP
	 KhEFYNzYEjNgqruwRZcSaxhYzi+tHV8ccrzz9Ug9gVM/zxWjJH9AjRP9lwe0HyOOQ1
	 i1Kb6roBOX0aA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFE33804CA6;
	Tue, 20 Aug 2024 10:56:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <172415139631.1106812.17850672117012037648.git-patchwork-housekeeping@kernel.org>
Date: Tue, 20 Aug 2024 10:56:36 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v8] Add QPIC SPI NAND driver (2024-08-20T10:42:31)
  Superseding: [v7] Add QPIC SPI NAND driver (2024-07-24T11:42:24):
    [v7,1/8] spi: dt-bindings: Introduce qcom,spi-qpic-snand
    [v7,2/8] mtd: rawnand: qcom: cleanup qcom_nandc driver
    [v7,3/8] mtd: rawnand: qcom: Add qcom prefix to common api
    [v7,4/8] mtd: nand: Add qpic_common API file
    [v7,5/8] mtd: rawnand: qcom: use FIELD_PREP and GENMASK
    [v7,6/8] spi: spi-qpic: add driver for QCOM SPI NAND flash Interface
    [v7,7/8] arm64: dts: qcom: ipq9574: Add SPI nand support
    [v7,8/8] arm64: dts: qcom: ipq9574: Disable eMMC node


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


