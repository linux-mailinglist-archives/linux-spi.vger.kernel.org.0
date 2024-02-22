Return-Path: <linux-spi+bounces-1475-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CD2860025
	for <lists+linux-spi@lfdr.de>; Thu, 22 Feb 2024 18:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF5C28C5DA
	for <lists+linux-spi@lfdr.de>; Thu, 22 Feb 2024 17:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06B4155A55;
	Thu, 22 Feb 2024 17:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afjYZOzZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB721552E2
	for <linux-spi@vger.kernel.org>; Thu, 22 Feb 2024 17:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624577; cv=none; b=XnSdMHzZLR7nHFQI4vG+lziayTFvggRX1UzH2GooObOMNwJ6u6bjglvT6xdkp3bgtGcVSHrqjJLB6iDPlZiInURI5djzzCJSg7mjCIxMNgwuYIEY9O/iRHaY+ZL+FkP01I2K91oAnbQBl/gl+8qkQT9fyLxuODSc/OU7W06utYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624577; c=relaxed/simple;
	bh=MGO8OqjjXW1LVRS5RKhNy28SGCFy0KpiLH312OvqVUU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=bNgPi9nFHN2/FmawJOfeaGfNFPqM5MhTRBnm9WwJS+KzsfMErVHgLUQJ11v0I+0DRki5ZyiaTE8ehJvjGrmplKB0dtity8P0XgC0jHePk/ZPxpQd7Liaop7m6x2jyyK70vBDhfBMSOR9enMceGAkkQOlk4zQ9OAmF04n1MsZLmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afjYZOzZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0554CC433F1;
	Thu, 22 Feb 2024 17:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708624577;
	bh=MGO8OqjjXW1LVRS5RKhNy28SGCFy0KpiLH312OvqVUU=;
	h=Subject:From:Date:To:From;
	b=afjYZOzZcQVBv+shzCLGDai3EWpm4TRG/kQgg3wezM/+9IZb+/GU7k3OlypaQRDu/
	 IlSIQ2lJ1fNNNCLFtksGq1BohTL1zxnru6bwObyXvJgv0dlh6BHl4Hld8D4yYdIphp
	 Tf7cx6B4CNJf4kf+sIfjsJi6p/AoCmfw4hkm2KHKg5yu2cjPbrk2+Eo4nlGFTX+uiO
	 P8DJKxMlMUkhTDk2bEB49NPygW3iML6CW6VHyYU4olJz5tmZz1DaJNXiqZc4OYSt7y
	 0FbL0q5nnnNuLWejAXrg3oZ0beS03DKdwgBuB4/dJN5SfVic47dbNOAqTeQdZKM5Gk
	 nHv2ZDZ+oIz+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE637C395F1;
	Thu, 22 Feb 2024 17:56:16 +0000 (UTC)
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
 <170862457690.4685.13028230912043679716.git-patchwork-housekeeping@kernel.org>
Date: Thu, 22 Feb 2024 17:56:16 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: dw: Auto-detect number of native CS (2024-02-22T17:28:43)
  Superseding: [v1] spi: dw: Auto-detect number of native CS (2024-02-15T18:00:45):
    [1/3] spi: dw: Convert to using BITS_TO_BYTES() macro
    [2/3] spi: dw: Add a number of native CS auto-detection
    [3/3] spi: dw: Drop default number of CS setting


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


