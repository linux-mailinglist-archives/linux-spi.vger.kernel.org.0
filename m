Return-Path: <linux-spi+bounces-2327-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F708A2310
	for <lists+linux-spi@lfdr.de>; Fri, 12 Apr 2024 02:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C5661C21BF4
	for <lists+linux-spi@lfdr.de>; Fri, 12 Apr 2024 00:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81B41843;
	Fri, 12 Apr 2024 00:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/T0ixCh"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E0A4C70
	for <linux-spi@vger.kernel.org>; Fri, 12 Apr 2024 00:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712883401; cv=none; b=ivezOpMP7lJjDLhRnzkfTx3k+NqbOiVaGb4vlyHBY/0WhT6uEBbcLO6bQYvlmo6xAKjFdM+dvh9Z7K50hN8ddwHBaFSKKrufhHPt55cTsouoSAnw9Xwh2w9phJK4BHtxMT7w+7nxtddA85pOgOsdR1ri8Mt7E4UXIPvkBzgdA0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712883401; c=relaxed/simple;
	bh=CAth8iJ3smcyscadRLDb5/dPuF8v0WxReYjA2vR/CCk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=pWkwbSAUPSgklSexMmG3Bui2gvj6dbWifqXXvV3hvHlHTTVOIzhJjpDB8206i0JAsflRAVfPDjhQ9N9cO/kuE654bBXui5FXJn97ajTdZWPir1pI8+LPvNNTeaCDU+8fAc25NMdAXAegpUnZqJhVnqYZI+UNe79lONdPOjUEDg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/T0ixCh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3AB5CC072AA;
	Fri, 12 Apr 2024 00:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712883401;
	bh=CAth8iJ3smcyscadRLDb5/dPuF8v0WxReYjA2vR/CCk=;
	h=Subject:From:Date:To:From;
	b=G/T0ixCh/Ssn4MzIZSVihM2LCeudruycExnSq0u+3ldYssa0vBymMY5PFkXpuXFV5
	 dSW5Dm7v+kMBdaoiIg+bkAZruVqNt+28UecFLrfMteQrbhP7CgQiV0dJTShtfuD2FS
	 VT4u46qY1hKPAYCbuTEWHoNo7WFfs0ZJ9tblN1prz4ypu/QcZN8bbr2mDGOc5D6Pta
	 WzRWEh1FGB9Pd6Bg1XJka7zHWsn1naL1Tr/0Sp5aK68n54BIqk8a0yBOQqIQeZ52E7
	 i+i5+ImwmL7dN0hIy4GatqWOAy0RrqCNCFZjrYQJVeIjul/Zxyj3rlLBVUC3nf3fZJ
	 JcSWz08Al20WQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B950C433E9;
	Fri, 12 Apr 2024 00:56:41 +0000 (UTC)
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
 <171288340105.24066.11394423059917104014.git-patchwork-housekeeping@kernel.org>
Date: Fri, 12 Apr 2024 00:56:41 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] fw_devlink overlay fix (2024-04-11T23:56:20)
  Superseding: [v2] fw_devlink overlay fix (2024-04-09T05:37:01):
    [RFC,v2,1/2] Revert "treewide: Fix probing of devices in DT overlays"
    [RFC,v2,2/2] of: dynamic: Fix probing of overlay devices


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


