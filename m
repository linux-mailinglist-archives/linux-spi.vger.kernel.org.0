Return-Path: <linux-spi+bounces-5616-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8C29BC47A
	for <lists+linux-spi@lfdr.de>; Tue,  5 Nov 2024 05:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACECB281F7F
	for <lists+linux-spi@lfdr.de>; Tue,  5 Nov 2024 04:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5290229D05;
	Tue,  5 Nov 2024 04:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2LFIF1o"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8E3817
	for <linux-spi@vger.kernel.org>; Tue,  5 Nov 2024 04:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730782578; cv=none; b=sdhJPuCGImRiRuw7rEDkBinhhQ08lIMQDobQCY4nTYEB4ChJUHHiUIanE0mLeGJGbKNZvlEvT+jCQy0FcmNdvSz1AVeWR9YK/ayfzewj+EvkZh8TzG83iqsvMJ74n9MdQz8s/o+NsfFS6UPCCGeiR4GDxjzJMOssJpQjPoQ0iWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730782578; c=relaxed/simple;
	bh=w7UPJZqr6GaIjTBrxPTIll6oNd04NvpBZFfvOOV3fys=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=qybMVqyIJAdmkGWOELmOX1HLRwRNPs36v0X0Hbx+0OzUV6SJxziG8xF+ae+2iWuxJ4hUqzjyDVaYJkPUqx8WdJtpLXfqXeSYroiXY4lJL6lYoj1B5mDpnXys7aYvQUibYmV6YQf88hwzqA8M7PIOi+aJgo8tM2bzvLTOowKBeMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2LFIF1o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0060C4CECF;
	Tue,  5 Nov 2024 04:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730782576;
	bh=w7UPJZqr6GaIjTBrxPTIll6oNd04NvpBZFfvOOV3fys=;
	h=Subject:From:Date:To:From;
	b=o2LFIF1oOlerpQxmonw2Am9PQlwYIk3lJ9o4znyq49kBxBgUdhqNMi0qr0WvK49kV
	 z2BIAfUHZZmjYQnZh8GotYXZ1VnLpb9G9t1o6+2eMecPjIOcA/kYly3MwQ43doUjgy
	 b8FCYZ2wu5jHOzFeGQI51m3SwN310cxk0cyOLMVvsKvsDT/vbQdVvvyip06bEpABKF
	 WgedK9FSu6vzuwpMpQbndQRk9d55mmlK1a+Uk+F0Tf9NNSpavKASSjNefYpaEP4nbP
	 eZO9Iv1CIOoDe8tulViRxrt7fZ9ZAs7jR2NMWwrtTgz5EKGhqNlSXoGIeXeW1YpxiK
	 awKeUXIklmtDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 74EC73809A80;
	Tue,  5 Nov 2024 04:56:26 +0000 (UTC)
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
 <173078258492.120604.15509678537737829202.git-patchwork-housekeeping@kernel.org>
Date: Tue, 05 Nov 2024 04:56:24 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] spi: Fix deadlock when adding SPI controllers on SPI buses (2024-11-05T04:29:16)
  Superseding: [v1] spi: Fix deadlock when adding SPI controllers on SPI buses (2024-10-24T14:56:11):
    spi: Fix deadlock when adding SPI controllers on SPI buses


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


