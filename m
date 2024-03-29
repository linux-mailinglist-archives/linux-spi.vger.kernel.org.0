Return-Path: <linux-spi+bounces-2104-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC38889165E
	for <lists+linux-spi@lfdr.de>; Fri, 29 Mar 2024 10:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69D54B2267A
	for <lists+linux-spi@lfdr.de>; Fri, 29 Mar 2024 09:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2274CE05;
	Fri, 29 Mar 2024 09:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRyIgXZl"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C5F28DC1
	for <linux-spi@vger.kernel.org>; Fri, 29 Mar 2024 09:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711706214; cv=none; b=IlCFksoZ4kavqG9+YAc0Gfkm2zwSltXItcBh0cCNLDGIYcY7qDFTv6+lLof60JhjwL8NbvszuSrezo5a+57rNxyemizTFG3fKLwAYpecL3+jWkaOBHFG8iAI+n66+Qebqms1dYVHlShhvJdesgRkIMru20pP07Wgp28Ggoeg/7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711706214; c=relaxed/simple;
	bh=0zNL1u7GFMKGv1/U6JLVRqYLPP9D91/E01IRNqS4FSw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Hj0fa/3ltff6Cf8vCqzOcbm4JPRLQh/2z7dvzlBYnDkEh8aV67rDkeg5LkL//WOo8eNLjLmtgpGuP36lI2ikGMI2VhsyULe9/6EXo6jg0MK/2/HGe7qnfk/tjRbKUJRFuNyxzpvGVvxFlWypDVR+eBMCzY+52KVWz0fQq3q4oqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRyIgXZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C44BC433C7;
	Fri, 29 Mar 2024 09:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711706214;
	bh=0zNL1u7GFMKGv1/U6JLVRqYLPP9D91/E01IRNqS4FSw=;
	h=Subject:From:Date:To:From;
	b=oRyIgXZl+Wn4n9leS1l6aMGqSxmpeloNVgtja3iUQJEMzpVjwD1BFf28YpkD5+Gf/
	 ZHtse5DiGVZ/opRaBC65od237WYPfLdxvSNKyhqyw1x113oek+jRhDq7MtwBKYciOV
	 HKB9VIvoXQwJ+ezAfSqUHYmlmZNANH9BfzaSnP1kEWBVBS768yhVl/ZdSZyn4bSPbO
	 hqwBL8x9aiy9mUwLvrC26WAHgprOIKJQXggZGoKqxQ+32PU0NjMphAmozMYLcktwwp
	 zn/t4MCyL5JMMJb4dUpuC8oU4ZTswd+lCo/SJAbW0LTyDLh1LAyU47MIUq01/gcMHU
	 4AynX4WkadrHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3180ED2D0EE;
	Fri, 29 Mar 2024 09:56:54 +0000 (UTC)
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
 <171170621419.27680.6580463838961333182.git-patchwork-housekeeping@kernel.org>
Date: Fri, 29 Mar 2024 09:56:54 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] spi: s3c64xx: Use DMA mode from fifo size (2024-03-29T08:58:40)
  Superseding: [v1] spi: s3c64xx: Use DMA mode from fifo size (2024-03-27T03:30:41):
    spi: s3c64xx: Use DMA mode from fifo size


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


