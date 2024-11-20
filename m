Return-Path: <linux-spi+bounces-5779-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB569D37B6
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 10:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60E2628208B
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 09:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5AB19DF60;
	Wed, 20 Nov 2024 09:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoby5MR6"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEAE18EFC1
	for <linux-spi@vger.kernel.org>; Wed, 20 Nov 2024 09:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732096586; cv=none; b=imJ3zCI3Ci21nS4wMO9dPE0aLbudtUizoWKbkszjk39Q7BwOhaMrqdHYQoh0iV4B5navwNOcTGnYnEZ4llkbbTj2Fe7v/NNw5BL64m/hZLrjrpxUlR9c2nDzfHv4njndnNFdKS8NtO9w4zP8dNUBza/tBo2Rtwryiyd4xJJkK1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732096586; c=relaxed/simple;
	bh=xhm9uibh5ueUMTDKOPokQ+rc79PDHTkZL2YQvyXwFj4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=QGG01XtUmtt+SATmK+KHCxjDj+rcZua5cNeqhsLkBjD6BoW+nd7+TjgbfldtP0V+iNbLFkgSa/YjL0QcBM7k9LZBtrSKIUoISnfJ5s+ihuy/u1ne25OP8Zm8W6vVPF4jx2z/JYiR5e1YfaVCSe64JVMp5hMSIvO673PuwfK6h2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uoby5MR6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC8CC4CECD;
	Wed, 20 Nov 2024 09:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732096585;
	bh=xhm9uibh5ueUMTDKOPokQ+rc79PDHTkZL2YQvyXwFj4=;
	h=Subject:From:Date:To:From;
	b=uoby5MR6AUI7h0yGCnsZedSEw/OI5FqhJThWQUEfhiZzmK5Y21Rxz0nrQHHkO8Aka
	 DIKD4gFqpZkwk2dC95AxCcCFkZrqKHuSuoC9XTVjrfdNyrAZ7uHxNkE5f3YtdTnRqA
	 VGy89bwd/dfcbZKunuFVaaslt7j+2mjRreLFEM7iIYmED7Q+dYw8XpSEztgX8sdEes
	 bqvYl/ZjMpMgLpEKycGBEXCEpMAfUI8XiuZ64NWb8+ZzPCXgc0O3ews+AbnX65fh6Q
	 PumkXVVcgKNexQGz9cbTQI/rijXU1sTNBfrkN8GQlWHzewl1YfNsdFhxzjsRtvwQJs
	 wYDRZIZ73B/GA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CFC3809A80;
	Wed, 20 Nov 2024 09:56:38 +0000 (UTC)
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
 <173209659676.1160235.3423584981031925049.git-patchwork-housekeeping@kernel.org>
Date: Wed, 20 Nov 2024 09:56:36 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v14] Add QPIC SPI NAND driver (2024-11-20T09:14:58)
  Superseding: [v13] Add QPIC SPI NAND driver (2024-10-30T12:19:12):
    [v13,1/8] spi: dt-bindings: Introduce qcom,spi-qpic-snand
    [v13,2/8] mtd: rawnand: qcom: cleanup qcom_nandc driver
    [v13,3/8] mtd: rawnand: qcom: Add qcom prefix to common api
    [v13,4/8] mtd: nand: Add qpic_common API file
    [v13,5/8] mtd: rawnand: qcom: use FIELD_PREP and GENMASK
    [v13,6/8] spi: spi-qpic: add driver for QCOM SPI NAND flash Interface
    [v13,7/8] arm64: dts: qcom: ipq9574: Add SPI nand support
    [v13,8/8] arm64: dts: qcom: ipq9574: Remove eMMC node


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


