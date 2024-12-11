Return-Path: <linux-spi+bounces-6012-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD699ED2DD
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 17:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61A41167999
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 16:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6341DDC2C;
	Wed, 11 Dec 2024 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5TNpRPR"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA861DDC3A
	for <linux-spi@vger.kernel.org>; Wed, 11 Dec 2024 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733936178; cv=none; b=hopF3cbj2qFnN98cpm7ZvwC9/rfEJci+XXJVcDzQigWcM4NZattSpLZXnxOJ4rUE4sO3zpmcc423+pVYBzp4YPmQjaDZYFdr5IYr7x+K3k3AnP3QfbgDg/J6xuX8AZiTDeGD4+KKc9baQfDLCsA9DhPeLhZF+qMrk5Xx3KQquO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733936178; c=relaxed/simple;
	bh=8bwg/RDqrG/YYlRk1CSkIODObcs5WGnYj6emA+jXSfo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=kC3h+e01SmoVz/UPZ3HKFHeyNTa8ZcHYHJZo6bOVA2hfbqP7+aN3IGtZnQR9gSJukZKQqSLnVsgXFP4DRYRmRQzlIpSapUEmUQwY1msQB5jvI/RzoXnQcyRpgdeAjTMcqxWbPF38P/gBeCcN3MJ6hv7te/mn2KlaEMUQoQlQ5zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5TNpRPR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88976C4CED2;
	Wed, 11 Dec 2024 16:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733936178;
	bh=8bwg/RDqrG/YYlRk1CSkIODObcs5WGnYj6emA+jXSfo=;
	h=Subject:From:Date:To:From;
	b=r5TNpRPRN2Biy0AzX0xM2ZPbeFL5e3WPVkiuvAhngPWhBq+kmhRu+9gA7/9ffHsxT
	 M90Ojq2pZ8twHtb7B+hCc1QKLN/dnqwioX+YAxKHZEJ0zBVXOXW7ULvZXp6JDh1JIF
	 /Wr2/MUj8kYnzqzyRxyAf0hGgCRwObLHdJTjT8Kc8bJkKDqJ9LWE+2hzrIwsulEmLd
	 FjXfPO2DLma6p3da7fqn8S4AYjvO1gLSxoYqXBGBOI+2yIgpXismO5B9BCc7/vWLzf
	 76appcZ+al+Kvh0EANd4alnkDiRM7yJ2FnWMri0toyQ0e8T3I6s+1qbkLuzE0XJdqC
	 zzTsDGTda0b/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE047380A962;
	Wed, 11 Dec 2024 16:56:35 +0000 (UTC)
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
 <173393619432.1643759.10643923386832431825.git-patchwork-housekeeping@kernel.org>
Date: Wed, 11 Dec 2024 16:56:34 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] dt-bindings: devicetree: explain how to get CS active-high (2024-12-11T16:50:50)
  Superseding: [v1] dt-bindings: devicetree: explain how to get CS active-high (2024-12-11T13:40:17):
    dt-bindings: devicetree: explain how to get CS active-high


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


