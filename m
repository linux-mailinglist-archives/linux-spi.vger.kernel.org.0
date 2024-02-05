Return-Path: <linux-spi+bounces-1044-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30491849B36
	for <lists+linux-spi@lfdr.de>; Mon,  5 Feb 2024 13:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62F791C220F1
	for <lists+linux-spi@lfdr.de>; Mon,  5 Feb 2024 12:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B262D04A;
	Mon,  5 Feb 2024 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGvs0he4"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A332D046
	for <linux-spi@vger.kernel.org>; Mon,  5 Feb 2024 12:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137789; cv=none; b=SU22UkR19CSiLfcLsAz5fhu4sGuqSEeaZ5yEreK9DxeW1h3svEUB8O3xR4lzywp2VCt/o22H14KhKmKGVZg0kDH4Cin5zGCTCJaq3oNFzrAmHj3H+NRCI7TMZibal7LoibaVy4goQZ0JQovvogVxzFbwl7wTGCKrjnV/SnLpImo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137789; c=relaxed/simple;
	bh=PFm4IdSNfb5cf/R4Bx+QYM+dFE2GM79npQc/Z1K8th4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=o0L4+merfhA9ZuIxOnCu4z+vghJRGejAXcAHUwKC64Lg9C5jFMeqj9j1VsLSr9QPAyjn6TYI8USb/8X0iSEb6QmweNOmQm2oraXiUiD535C9y2M2kz/Xp0gTGhqwp4HV8wmlqyrD2RavDkpsYoTQL2XESE+kFaRhiNd3vn0BIXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGvs0he4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B184FC433C7;
	Mon,  5 Feb 2024 12:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707137788;
	bh=PFm4IdSNfb5cf/R4Bx+QYM+dFE2GM79npQc/Z1K8th4=;
	h=Subject:From:Date:To:From;
	b=QGvs0he4iXSST7+JpdOTkF2ZFFuwMWdWgcvX1bWkKBUo2Mt66GDq0kug9LIBRsslb
	 1+aw2aFVDNCw44rTUdR0P6tK0AzgBRSNT8ZRatnEHUcglXDeCoPCemz7DGgQcqqc0x
	 mz6r06LORuK4vu2NSHfUGptkAoUq9mkOjsi8OwqWpGjI+ixjGsngpzwEjLbJUfhU/e
	 Z52/bvKqQRU9kFZ746O5GWcHg9rphTWLjcoCeQC/DzF1QGYwpFqfhBhxUpWCvoGCD0
	 u9Oy7q4aAxUT/tBAmGhNPERXVx71ElQSLzSWegSDq0Qc/ig9qYZgxMm5i4k1PW1LnB
	 3aRvHpiMz/KDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 954A3E2F2F1;
	Mon,  5 Feb 2024 12:56:28 +0000 (UTC)
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
 <170713778860.18822.7967921176599659199.git-patchwork-housekeeping@kernel.org>
Date: Mon, 05 Feb 2024 12:56:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] spi: s3c64xx: straightforward cleanup (2024-02-05T12:44:57)
  Superseding: [v3] spi: s3c64xx: straightforward cleanup (2024-01-26T17:15:29):
    [v3,01/17] spi: s3c64xx: explicitly include <linux/io.h>
    [v3,02/17] spi: s3c64xx: explicitly include <linux/bits.h>
    [v3,03/17] spi: s3c64xx: avoid possible negative array index
    [v3,04/17] spi: s3c64xx: fix typo, s/configuartion/configuration
    [v3,05/17] spi: s3c64xx: sort headers alphabetically
    [v3,06/17] spi: s3c64xx: remove unneeded (void *) casts in of_match_table
    [v3,07/17] spi: s3c64xx: remove else after return
    [v3,08/17] spi: s3c64xx: move common code outside if else
    [v3,09/17] spi: s3c64xx: check return code of dmaengine_slave_config()
    [v3,10/17] spi: s3c64xx: propagate the dma_submit_error() error code
    [v3,11/17] spi: s3c64xx: rename prepare_dma() to s3c64xx_prepare_dma()
    [v3,12/17] spi: s3c64xx: return ETIMEDOUT for wait_for_completion_timeout()
    [v3,13/17] spi: s3c64xx: drop blank line between declarations
    [v3,14/17] spi: s3c64xx: downgrade dev_warn to dev_dbg for optional dt props
    [v3,15/17] spi: s3c64xx: remove duplicated definition
    [v3,16/17] spi: s3c64xx: drop a superfluous bitwise NOT operation
    [v3,17/17] spi: s3c64xx: use bitfield access macros


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


