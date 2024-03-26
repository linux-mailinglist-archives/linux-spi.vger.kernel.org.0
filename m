Return-Path: <linux-spi+bounces-1995-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E1B88BFFA
	for <lists+linux-spi@lfdr.de>; Tue, 26 Mar 2024 11:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCD6EB239C6
	for <lists+linux-spi@lfdr.de>; Tue, 26 Mar 2024 10:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971D779DF;
	Tue, 26 Mar 2024 10:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKGGaG+P"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B833C30
	for <linux-spi@vger.kernel.org>; Tue, 26 Mar 2024 10:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711450600; cv=none; b=F9kYQqMOD7JJ/sgcNbL8ipAk5O7b7ezBjCutcqSv3gFe8cPO4RB/b3YLOqf6AkdsOPtphBog75cH/Vy9PTVNIGq2Lm4vAUnO9ByyBBJV4Bjm4LV8LPj5CElYHi/oS2gcDt4e+CIkFg3eLL8gnWvXTEOg2O75uob8Q4jwehp+GyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711450600; c=relaxed/simple;
	bh=z157qjpwdt8errmAH3HnqJlZ71Cqk4+CkdcBYuJs/H0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=qirhfPgrhlpsp8nljgnXIaDBOSEKR8rIMhTwxpaAErrCpGOm3QZaPR/UCmnv333DNERsI741HBllgWYWIkTrIKTDZwA+LyGEcA6XPlodqtKof3KWAaWFq2zsenUEiNMqaeafiA37YXQpEhMaBiDm2nNGpket+B2DpjfPJWOnZms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKGGaG+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8B84C433C7;
	Tue, 26 Mar 2024 10:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711450599;
	bh=z157qjpwdt8errmAH3HnqJlZ71Cqk4+CkdcBYuJs/H0=;
	h=Subject:From:Date:To:From;
	b=QKGGaG+PZ5laNHG1rgjZKiZ9gJ8TC0adK4nQi7R9mWDqiALpVep+hvbRpsV7pvYtN
	 s9rBOUzmvCns1agSfU3/ksOygNzbePco6mQHKGkLZW3nwZKn7fgDBQ+UVDPhcKF5HS
	 CC25z5pkBw3rNPBYE6y85dmI4WSTTYlYuOcLYGvUwH11fBwZAf6QBOkgOR6N88xCh0
	 AmhpyM7QHlL1agP6Gd0GgRxHFJscC/0F3p3rZYSmJ91R9R9w8xGTrCEpZcFOKtyCF9
	 /Wm03CshF1HtKSyKhvAMRpWwf2OJ8sV1TpdM5KYL/gb9RHj3OiuyJE+iDrM5i1Aett
	 +jqjP2/Bv8SEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0C90D2D0EC;
	Tue, 26 Mar 2024 10:56:39 +0000 (UTC)
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
 <171145059991.8856.8590897302137314994.git-patchwork-housekeeping@kernel.org>
Date: Tue, 26 Mar 2024 10:56:39 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] spi: spi_amd: Add support for SPI MEM framework (2024-03-26T09:57:07)
  Superseding: [v1] spi: spi_amd: Add support for SPI MEM framework (2024-02-29T13:45:44):
    spi: spi_amd: Add support for SPI MEM framework


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


