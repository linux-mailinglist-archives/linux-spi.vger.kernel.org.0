Return-Path: <linux-spi+bounces-8685-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43925AE12AC
	for <lists+linux-spi@lfdr.de>; Fri, 20 Jun 2025 06:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23AB3BC8B1
	for <lists+linux-spi@lfdr.de>; Fri, 20 Jun 2025 04:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACCC1E521A;
	Fri, 20 Jun 2025 04:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QS1vdDLf"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A831F150A
	for <linux-spi@vger.kernel.org>; Fri, 20 Jun 2025 04:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750395373; cv=none; b=hiVACVYe6yLNKFxNy4yiQaP9cHfTYQ+zuTbll0bUr838+EQgBJ9Pd7SpasjwdLAnIVRGmSCsj1yzplNUajZ6sHSAomlgcDXyyaDPlSCiedoSjiJ2nHFr9AmhYRcuCfpnrHLN2ScqjAXL74f07In+m+qkxnJ5p9TKHBNNeJH8pP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750395373; c=relaxed/simple;
	bh=EfRRJL2vWD5j5ABrrEFcltKzJHQ1yctU/ZjEZ3/D+hM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=lCGnLaKCBaaDUDvThkOpd0PdORODoRg8SjUJUOlmYyzinGb6mksqjCReo84WS5ejGPSehDjJSE3UK4uA1ieCp3AeSSiUyUnvDFojh4rWmcdK7xlMecR18DNH6I38OY4OE599NfxmjmB0GY2E8mANmhm6Gaxi3IXADjGn9cLoYfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QS1vdDLf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D826C4CEED;
	Fri, 20 Jun 2025 04:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750395373;
	bh=EfRRJL2vWD5j5ABrrEFcltKzJHQ1yctU/ZjEZ3/D+hM=;
	h=Subject:From:Date:To:From;
	b=QS1vdDLfSzH43t1nmr+DTJVU9H0Wd4I1Jle8Kry8zW6TUkHxXYUHss8orclZ+w1EF
	 2M4bkbtGvmunQQ43HpzJECYNIn7A33zjGJfG+kp7l/aBMxuNrh/RIFfYgCiKuFhxoB
	 lLHNewb+wvbMZKG1EeRF+3fJkz1lyQnF8blLyQOjtvrct0PXallp7mmFNuobVdejZ2
	 5BoxQGo14gV1Cxjat7KRFytwQdKw7ztcDoypBSyEEQu4cLEtTwpXD7ICzwYAAmT1/d
	 o9cWewxdmeI3uAkh9rCMluPckORS9R6AGhMA7nayjKlm3hJNJhl4DLraqFGirWbesc
	 u643uJKCPJ0vg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BFF38111DD;
	Fri, 20 Jun 2025 04:56:42 +0000 (UTC)
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
 <175039540075.1082171.8835078669019385068.git-patchwork-housekeeping@kernel.org>
Date: Fri, 20 Jun 2025 04:56:40 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] Virtio SPI Linux driver (2025-06-20T04:12:27)
  Superseding: [v4] Virtio SPI Linux driver (2025-04-01T03:36:18):
    [RFC,v4,1/3] virtio: Add ID for virtio SPI
    [RFC,v4,2/3] virtio-spi: Add virtio-spi.h
    [RFC,v4,3/3] SPI: Add virtio SPI driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


