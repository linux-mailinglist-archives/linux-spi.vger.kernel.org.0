Return-Path: <linux-spi+bounces-6996-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9097DA4C109
	for <lists+linux-spi@lfdr.de>; Mon,  3 Mar 2025 13:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B719C163199
	for <lists+linux-spi@lfdr.de>; Mon,  3 Mar 2025 12:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0841D78F4F;
	Mon,  3 Mar 2025 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqlXHTue"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D852F3BBD8
	for <linux-spi@vger.kernel.org>; Mon,  3 Mar 2025 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741006566; cv=none; b=bVqyog7zGJC2tbga3Ny3I1E9nc681D/I7rlCJD2qoTWUcLIIxCIwJtg0buEtP97pUH8EIn0rfO0chyRDRiCbkmriwGjVJLl98yN+N6X+ieWLdUI3gYPmE0XL37mTP0Fj4plxgd1yzBLcJSmBSP23oXlPLwMX1qjPQtdoTOgFxd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741006566; c=relaxed/simple;
	bh=bK/flrzUqhSH5ChFenfnFE2kLmEvqikUuCIatp4N+bw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=pnPuJeCiJZeHZJVaZUR1/q8JV4tSmzS6lK34m8PJWQUZX/gSi1ibUQEzWkHcq/9nFLx2P1cXu57xytFAZlsLAQcSb2L6QETubIrg1p71qDdGLMv5iaFI/alm7FnoeAQPEQxGpcwlw3tiAaKXZESYuxWyL+Hiquy8jaGBh22Jufg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqlXHTue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124B1C4CED6;
	Mon,  3 Mar 2025 12:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741006565;
	bh=bK/flrzUqhSH5ChFenfnFE2kLmEvqikUuCIatp4N+bw=;
	h=Subject:From:Date:To:From;
	b=KqlXHTuedihc0K1tT0Xty9e5py3apVZNSsuP83dyQg23jCrr4LnIA1CEKGdG8vjdK
	 j4ROQ1DwhLU3MA7/vl+wQggtMIcKrV9h6emexCtD5feWTnpNbfTgf20TbNCzXPMprB
	 RdGkoplkSUA1RJUxRvIsVyc9Fh64pNbX68L9q/vK3+NUVB0ErJ0ik92xVDLGQrLL0f
	 5F79Sgy0ALZMgZQtOdZOLpKfwVIC9GCGHwj+A7gXESCo5t0kROK32hzByhYriMinI1
	 FX8ETC06h0PE+0DycIXmpSE4i5ifP6WSPFxMBV28xRjPD4cXgBBudCb4nV9XBcmdIW
	 GO4YUTjAQfRYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0653809A8F;
	Mon,  3 Mar 2025 12:56:38 +0000 (UTC)
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
 <174100659764.3569529.17277835043548701329.git-patchwork-housekeeping@kernel.org>
Date: Mon, 03 Mar 2025 12:56:37 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] Add support to load QUP SE firmware from (2025-03-03T12:43:40)
  Superseding: [v2] Add support to load QUP SE firmware from (2025-01-24T10:53:02):
    [v2,1/8] dt-bindings: qcom: geni-se: Add 'firmware-name' property for firmware loading
    [v2,2/8] dt-bindings: i2c: qcom,i2c-geni: Add support for selecting data transfer mode
    [v2,3/8] spi: dt-bindings: Add support for selecting data transfer mode
    [v2,4/8] dt-bindings: serial: Add support for selecting data transfer mode
    [v2,5/8] soc: qcom: geni-se: Add support to load QUP SE Firmware via Linux subsystem
    [v2,6/8] i2c: qcom-geni: Load i2c qup Firmware from linux side
    [v2,7/8] spi: geni-qcom: Load spi qup Firmware from linux side
    [v2,8/8] serial: qcom-geni: Load UART qup Firmware from linux side


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


