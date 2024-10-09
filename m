Return-Path: <linux-spi+bounces-5166-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCCA996034
	for <lists+linux-spi@lfdr.de>; Wed,  9 Oct 2024 08:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED202876D8
	for <lists+linux-spi@lfdr.de>; Wed,  9 Oct 2024 06:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265EB40849;
	Wed,  9 Oct 2024 06:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GosD90Mh"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ED75103F
	for <linux-spi@vger.kernel.org>; Wed,  9 Oct 2024 06:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728456977; cv=none; b=EznFP8zhBJI4P4ETME4zaSryMJ/ajqCGigfRlwbphzBdPoV1tWDultsdG0+lGMiWLgCrwuDWczKyl/rxPC/ygE3Um8si5aOxZSMCJAPOq2o//sc9vKiOSbr3n3K8fw6wkM/uEKdUGAPc0+iUkd9q9kUg2uE3oO93PJMCATEr3N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728456977; c=relaxed/simple;
	bh=fFusUSd44wAhuHda1rC4SWOlH+stThgPSP7qS2O+Fl4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=YQU8HqH3Kbr+jxHxg+s2NE7lKnBdZ6TCd6Ji3+02pNjh8rRX65OiaUeF+7HBRatW2HU70d+G8pp6m8Sx5UkiOkdvoo0V3ihxNKWS9XR5iCb6YoJMM+VHaEP5rOOzzlKJBWf9v0B9E+4VzkEYTNmB3srbjuRSv2FcSQjpjAUa0lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GosD90Mh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99506C4CEC5;
	Wed,  9 Oct 2024 06:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728456976;
	bh=fFusUSd44wAhuHda1rC4SWOlH+stThgPSP7qS2O+Fl4=;
	h=Subject:From:Date:To:From;
	b=GosD90MhG+olJJDX7+4HGRslVva82GYveAmRvbR1VEmILjFTL57mB7fKChdYlOzOy
	 wbe/HL2upu4BVKJ6jBQDWC46IJ+FOl1qo1iYZ+VtyXkfCEQ8tQSy2ddFEjkW4O3zTB
	 TgBQs0PkhuKGu9oMQZsxFZxm1Rtm/+msqUSC9qeu8StSKdcW0nJUYw9/kZyAtdLHcn
	 /FknO8POZvPiValZOjqVcLrPIQXwgwbI8mizPYY8L75oMwxKQu8iwpgJTP6vPaB8A+
	 DCNN/2itUT7SAry6iQXRaFks7kJKWZy3JbIODJQeYgw9Vf8Dk31x6gYMB5jsBaMogt
	 YJgCHS7I4t7ZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1E333A8D150;
	Wed,  9 Oct 2024 06:56:21 +0000 (UTC)
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
 <172845698055.838710.889501680739789028.git-patchwork-housekeeping@kernel.org>
Date: Wed, 09 Oct 2024 06:56:20 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: intel: Add protected and locked attributes (2024-10-09T06:22:44)
  Superseding: [v1] spi: intel: Add protected and locked attributes (2024-10-09T06:12:02):
    spi: intel: Add protected and locked attributes


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


