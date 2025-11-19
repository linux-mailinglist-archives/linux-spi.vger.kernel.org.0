Return-Path: <linux-spi+bounces-11304-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD04C6E1BD
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 12:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CD52E34A9BB
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 10:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D8C33CE88;
	Wed, 19 Nov 2025 10:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKPmetdb"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2133093A7
	for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 10:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763549876; cv=none; b=SUcMDYddVRY30VuHdQLM50uXc+H9geiApcSVMjaJ2ZQIVWNbLaO12lFD+RMUh0CAoUyPyljnYP5mGJPYSGCtq2x1tXo5ZWvjkbfYKw0bdhxBLZWv46Y6VwBhaJAVoQO7QZzWa8mfuEeHhpIjUEyzRZztqVZuKRfspTXybMCuLbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763549876; c=relaxed/simple;
	bh=xP4yv6tcnOR3oZf/AG9dJYRz8AWicsOZPaYSa2Lrpig=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ReqGXB+IPO4HPYHfDpxFeckajvQJSN+jlDPGQi6ueVW+JtFtoU4wyqDtIymcUmFZQxh5Ra7xQZepu1PS7qkp9YNh0TkwA7RAFlIMUqQyTE7K9+piVZ+oDokyBG6zLXSipt9wsDrRpDFJRdo/tqjPfLVfIaRrz/FIfusS+2konfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKPmetdb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0E9C113D0;
	Wed, 19 Nov 2025 10:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763549876;
	bh=xP4yv6tcnOR3oZf/AG9dJYRz8AWicsOZPaYSa2Lrpig=;
	h=Subject:From:Date:To:From;
	b=JKPmetdbYnHTTBo8z4+U5pqU+9qQxCPoZncwW7jWz2TY7YCib2HfQG3UxeXnKpDm8
	 yVW5dt2/m+S3RLWDDLxx9yVL6yJkv1kzqp2kxZVeiXu3Kz9+Fr7GOzZNtJUt5xpJNK
	 9cQv/a8fdQin2nm7B2sy11iJMf15rAeMRgoNjc9pJ9bub2B4I9eDQdf6GcyHnpoVsI
	 8DRWbzRLpIGgYHf8LSxiQ+PFodQM3K1mw1rvs+fYZNt9McEYyHhdQ7tYX8pj+lZ5gM
	 +FrnBUE1R8yvqCriANbn5Bkloeb6cgC8FMu+Acxnxr8BMZ+NDwXFihl7GRG1xCV/jp
	 TKibrz4r3DIlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EB2380A97B;
	Wed, 19 Nov 2025 10:57:22 +0000 (UTC)
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
 <176354984084.726555.5642704433306286614.git-patchwork-housekeeping@kernel.org>
Date: Wed, 19 Nov 2025 10:57:20 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] Add support for NXP XSPI (2025-11-19T10:42:27)
  Superseding: [v3] Add support for NXP XSPI (2025-11-18T03:34:15):
    [v3,1/2] dt-bindings: spi: Document imx94 xspi
    [v3,2/2] spi: add driver for NXP XSPI controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


