Return-Path: <linux-spi+bounces-5659-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 531839C2C05
	for <lists+linux-spi@lfdr.de>; Sat,  9 Nov 2024 11:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141B82828AD
	for <lists+linux-spi@lfdr.de>; Sat,  9 Nov 2024 10:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97EB14E2CC;
	Sat,  9 Nov 2024 10:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1+fjknA"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F82233D7D
	for <linux-spi@vger.kernel.org>; Sat,  9 Nov 2024 10:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731149786; cv=none; b=Hg7oZYidajb4pJfpAxjflQWtisqzdpVfpDwJPaQRXXMdkROHI6MaTuuRGM1Cqb+VDqK6NER1c/lTgCVj0Ri1AmOmsRBXleo8yk/qGN/xQC0WIxEQh3UTFwfYSIvKRyiU/1mpJ1g+bdY9QVSxSIAC9JJ2EehxapazjcHZfKWb+cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731149786; c=relaxed/simple;
	bh=dNwOtfO7dpwRqpVoBxTmcZxP5dmhy62aZjRzTv+qZHo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=nwah9kiSC/XkPRYNlJ7prAxIsDXVonr50WIX0WDA3wdTNGJ1dhsYngfYeqo6b7YCsV97HW8YzVPcxtyawROOJXTWLH6FQ5kl0tFGpu/IJQKcNViOfIhipWFh5cqG7dqpPoTCrjeFH5TwkgZ18G6uZyczyPUEL3VBR4yY8G6qJVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1+fjknA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA85C4CECE;
	Sat,  9 Nov 2024 10:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731149786;
	bh=dNwOtfO7dpwRqpVoBxTmcZxP5dmhy62aZjRzTv+qZHo=;
	h=Subject:From:Date:To:From;
	b=B1+fjknA+0SovcmewyoKoHnD8Q5Y/WydnDWPrAw9aGZg10yjkmssPYwC81WVBhbp+
	 wbv3aqdxWedB6Ew/YUQCg2rBgnY2OWmX4dwyAMIQPR1+EXi7TFoZZEvB0FD+H/dBLA
	 2eihuv5lr1A8fc6BUldJIBLxGz8nrC4rFmjy7mqf7nhQNZ34kCYmGcHVT39KuEfLCX
	 6Be2j/3aaZ2WHrXBR7wU5lVLmxrKIVs5OgOGrgHEDwfIgd2EajYIh4LdmhkPIBhIfs
	 tGvVgZ28Jnwkx6IDVIBhTGN+Ba1mcZnTVtZ+Q1Dy+bVE+ffU/OpdyErMeiLMkyTD+d
	 cyTNyqyXNg3Bw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B70023809A80;
	Sat,  9 Nov 2024 10:56:36 +0000 (UTC)
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
 <173114979506.2906442.4228646612106524872.git-patchwork-housekeeping@kernel.org>
Date: Sat, 09 Nov 2024 10:56:35 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] dt-bindings: spi: add compatibles for mt7988 (2024-11-09T10:50:28)
  Superseding: [v1] dt-bindings: spi: add compatibles for mt7988 (2024-10-06T10:27:39):
    [v1] dt-bindings: spi: add compatibles for mt7988


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


