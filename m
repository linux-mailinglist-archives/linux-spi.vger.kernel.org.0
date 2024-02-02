Return-Path: <linux-spi+bounces-984-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 285F6846E76
	for <lists+linux-spi@lfdr.de>; Fri,  2 Feb 2024 11:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4061F245B0
	for <lists+linux-spi@lfdr.de>; Fri,  2 Feb 2024 10:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE0513DBB0;
	Fri,  2 Feb 2024 10:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2/YGnBf"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5CE13DBAE
	for <linux-spi@vger.kernel.org>; Fri,  2 Feb 2024 10:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871391; cv=none; b=ADSUemx4o3KGQSh18iYcxtvggBV5irGPoFxONaMj3159vOE+GZwdn1sL9U8KY12r9UZNobqk+pM4C3LoKSCIt+NVoFVZlmbYA3xo4DOJDCLcy8BbVdStOtJ6zw+pkAnbEFX8/s9kKwh+DaNyx0NkYAxcjNsCnmsptDRGmhHUuU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871391; c=relaxed/simple;
	bh=ZsSJnCYpIV0bMMpvOdcxcmLxgqVBHU/7eWZxZwOQdSw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=odro/Z25EObs1rOknZetUSNsN7Zma9q34u248rTPgPtRjCtJ+Jnv4n2tG0oPKHSrxDIuC69qgrcRfBVTGr2Sif18D1xl28HjqZReYOUnLQuMBPCsUnXUjcNsW3fmnr162oCtNx2vj8uOpImCD2Sur1C9V9O0W33GEk3DqiOh7wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2/YGnBf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16E5BC433C7;
	Fri,  2 Feb 2024 10:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706871391;
	bh=ZsSJnCYpIV0bMMpvOdcxcmLxgqVBHU/7eWZxZwOQdSw=;
	h=Subject:From:Date:To:From;
	b=V2/YGnBfKsFRgSYnCcuFkE//YNkALIwW8DdAL/U93IGv/vfH5b+N1SCNO75aIGH3d
	 YPyL8N5f6hJ+8TobV46Tsdp6WpKYB1PhPdAog1/jus5GYBM13x3sdUrUFTBx+lVEGv
	 2BKl8sGSfPID/nTkeRM/J72LR4h/8JzGTAGhsj8dARfV4dyYdgR8kwwlX3Wzhw/Vsx
	 4+ev/tgln4WsvaxfVRQwpo83wlMXDat/vI98VT9jiydUMH03aZVUQ2O5vorTSmRHO0
	 d9NF0CG99vbh4NZgeXxnt20MlNohx8EgY1WmGTMPnUIaxvSKZ1rbI79lSXdDNtE7kc
	 JL+Q3w1j8Ldog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F1B99C04E27;
	Fri,  2 Feb 2024 10:56:30 +0000 (UTC)
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
 <170687139098.10807.4369088353905534135.git-patchwork-housekeeping@kernel.org>
Date: Fri, 02 Feb 2024 10:56:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: cs42l43: Clean up of firmware node (2024-02-02T10:34:30)
  Superseding: [v2] spi: cs42l43: Clean up of firmware node (2024-02-01T17:26:49):
    [v2] spi: cs42l43: Clean up of firmware node


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


