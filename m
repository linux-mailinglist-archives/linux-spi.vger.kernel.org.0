Return-Path: <linux-spi+bounces-4976-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83917986124
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 16:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40CD1C26B0B
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 14:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FB8188907;
	Wed, 25 Sep 2024 13:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrJKySF3"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CFE18893A
	for <linux-spi@vger.kernel.org>; Wed, 25 Sep 2024 13:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727272586; cv=none; b=DG1G09PajAjx3opdU7Sx4KBtvNDM0QfQ/kb64U58dpq4XUrdSe0xCMBhfw2xRa9zfg8/uAAe1aFs0c+g5UFefQSn3a+4jTRGXJyFp0nOjWxuLkNEdRQ0GbzUs+aI8naSnVjjgfa0PXZHtZ7cThnJbTot67CbHO2Ns8EcEh1eNQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727272586; c=relaxed/simple;
	bh=g7tH/VQMquunIU1trTkt0Z0wz2JbCBWHi+qq0Vr81m4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=m8yy7DNLb1EyZjs+lrRSRql+oRLrhqeC48fCUKYLPbRo86H+Rlz/ZP7DtW2i9KIzjQPCnQ1eE1WeHGJeMyIDd7kpN3fSOn6MZNk9hpyxuLT1M4JrJ1J4GTU0XkrXJYwVm00DWlBekfW4uc82rpdvGsyH++SsR7O0qfaYQXjqV7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrJKySF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EB7C4CEC3;
	Wed, 25 Sep 2024 13:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727272585;
	bh=g7tH/VQMquunIU1trTkt0Z0wz2JbCBWHi+qq0Vr81m4=;
	h=Subject:From:Date:To:From;
	b=DrJKySF3GBaurjyRciLGUuNw4vLvD/FkG2iKE3D4u26VAHzvIq8u3tnaIv2ITg0DW
	 VAzNqznTaVIs10ZFDYqI+w5kxKXYSdv+twSacVgfuA/jrmKRn1CWY5KGxoJkFeTugt
	 p0uDF3i6PPmDc3akEGpvHh0nR09AoGrnHlioSmqZ70j+P9GSlg4Inp2ciS3L6UWrCo
	 xju07U+uQnKN203Ii14bN0TuVzAvsDfE22LlyJ8V4rOKl7t9VoIE/4R3VHS6FnEB3Z
	 yDem47ijc71DvE/x2nuzIU5Sk21SjFAITSZ0sJ1Ujw5nc30vJTOAxj3X5kDeL4CKY4
	 X4w5epjS+uHHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B3113809A8F;
	Wed, 25 Sep 2024 13:56:29 +0000 (UTC)
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
 <172727258769.601159.6876456589557453047.git-patchwork-housekeeping@kernel.org>
Date: Wed, 25 Sep 2024 13:56:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: spi_amd: Performance Optimization Patch Series (2024-09-25T13:36:36)
  Superseding: [v1] spi: spi_amd: Performance Optimization Patch Series (2024-09-18T10:50:28):
    [1/9] spi: spi_amd: Sort headers alphabetically
    [2/9] spi: spi_amd: Enable dual and quad I/O modes
    [3/9] spi: spi_amd: Replace ioread/iowrite calls
    [4/9] spi: spi_amd: Updates to set tx/rx count functions
    [5/9] spi: spi_amd: Optimize IO operations
    [6/9] spi: spi_amd: Add support for HID2 SPI controller
    [7/9] spi: spi_amd: Enhance SPI-MEM support functions
    [8/9] spi: spi_amd: Set controller address mode
    [9/9] spi: spi_amd: Add HIDDMA basic read support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


