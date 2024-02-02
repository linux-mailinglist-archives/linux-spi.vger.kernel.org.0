Return-Path: <linux-spi+bounces-987-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7785A8470B6
	for <lists+linux-spi@lfdr.de>; Fri,  2 Feb 2024 13:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C6321F2BB81
	for <lists+linux-spi@lfdr.de>; Fri,  2 Feb 2024 12:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E0415B3;
	Fri,  2 Feb 2024 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eN/lDZkA"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CCF185A
	for <linux-spi@vger.kernel.org>; Fri,  2 Feb 2024 12:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706878602; cv=none; b=GO6JcFHZ7BK2Eug4XdqrTOt7cM5mYBX2sL5v75wdDLVLAAeEmNl8Gs46VMBmk1PSbw/pABhVl/ReJoLfLBXhGavHkKsHsC8EM4y9zE2B/8hFzRRp1cMclj+4BOqjS/blMzvS0E5DdhOYt2QnmS08FPaQI59iJQ1CTMP0p9wWBW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706878602; c=relaxed/simple;
	bh=UfLEwgMslcnJfVDQvsiXn3NbDDx3o5vMj/HGNnQ1ltk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=b9aAfy6CUx37L8YA/0bW0T37xPFhG2HKuacS+lkWYOrkQCPnOdT8kaEEuOdkIOiEi2iYMHS+ktcPmKLqVfjHtUU6Bw0LJxb+THz1uOdmBR3R8V8sa3WIFsV4yps1oOovBYZksD2M45pJEpQJvNNWoxLvCYjPMxPlXZWUrdCXAR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eN/lDZkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 794B3C433F1;
	Fri,  2 Feb 2024 12:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706878601;
	bh=UfLEwgMslcnJfVDQvsiXn3NbDDx3o5vMj/HGNnQ1ltk=;
	h=Subject:From:Date:To:From;
	b=eN/lDZkAMUQU8SiI5+VXx0HIG0nWELc5K6BdxGGSQkzMbOKbHXR+gFWyovLb6iMJc
	 lgg2Fi5Vm/IaE/m0yZyo9Nu37F4EVpSp76tvqsYFzFipU8SLieOuFLdZUBGiHcdqG/
	 vbEh8YsgFlPos+g3T9gm9PzdmbxZIo0Fqyr0SWCwCNGeaPXirlKr5xvX6nAsdx5TEY
	 wYCqU/BF+hvJt09n5WkJStOrGsVL6eZFToENL6XVpfrqIRDe6UcXWdjo/zGsxdYCTi
	 UjRfUqxQLhTY+lwhuW9t+PRoCOfkrGtXk6XbnhiliCmHQ1vN1WlUDw81Apot/tKs8h
	 h6SeiBv64zObA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E55EC04E27;
	Fri,  2 Feb 2024 12:56:41 +0000 (UTC)
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
 <170687860138.15551.10263603684825679457.git-patchwork-housekeeping@kernel.org>
Date: Fri, 02 Feb 2024 12:56:41 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi-mxs: Fix chipselect glitch (2024-02-02T11:53:30)
  Superseding: [v1] spi-mxs: Fix chipselect glitch (2024-02-01T13:15:40):
    [1/1] spi-mxs: Fix chipselect glitch


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


