Return-Path: <linux-spi+bounces-6654-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC6BA2C31F
	for <lists+linux-spi@lfdr.de>; Fri,  7 Feb 2025 13:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD91216AA18
	for <lists+linux-spi@lfdr.de>; Fri,  7 Feb 2025 12:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F551DED70;
	Fri,  7 Feb 2025 12:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdXTyYX5"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07077FD
	for <linux-spi@vger.kernel.org>; Fri,  7 Feb 2025 12:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738932998; cv=none; b=YhAV2aFPqyo32Ea50mC5mBVmKZnR7xxGuCsS5Bg1XpjmkF763ldGw9uUg84fiXSsC6+NPRFaHtMtRvA0GZpS2rYxC1boANS37FzdWO6JW2yy6JIsGgEIoffG3HV1WXz22N7kZb7XzxNuSNK48RGhTFo55mQvrvB7KkLof+SwSng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738932998; c=relaxed/simple;
	bh=XG+rEZbYJijWk+reLIxDy8OPfrnpJNoZvy391D0Uoc8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=c72gY9CKYATblK7l8/VcDRfhTDoZbtjIWFjoqf0Yvmmc6A/osZ85/cXWvq5b3X6I2sWSk3OnqaWBVrQYEfYLkG2X+64eBDv3zkTYau4oknPoiJjf/dc9odjmoVFuS3pN+yFRao9+893V1FY+7W+/7hdn/Z1d4TB/3lJeslIXkJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdXTyYX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D190C4CED6;
	Fri,  7 Feb 2025 12:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738932998;
	bh=XG+rEZbYJijWk+reLIxDy8OPfrnpJNoZvy391D0Uoc8=;
	h=Subject:From:Date:To:From;
	b=HdXTyYX5PKxqCYSO3YcROb569JXIwUgqoZXfGqAF8QfhRRksW5kXROXhKLxaeIVaM
	 Z8QV+cCY2bx5up2iMQbJEvgkIxx0SpZOzGwc2/0jM5xzO+kwvSyJyQWuAgCPCNG42t
	 Fn6f5yPFX5rq5B7Bs8AfaH7ye6FF9rQMVBelHwryWgxlaGkIKZ2nbhEHy6euODf49T
	 1HomlHyhSjvsnOHaQMEYX5y2HcgNGLSwPNk0wcT2uM6P+HyQ6ixQBfdPBmA9+B2umD
	 NbKiwOpMwFf3C6LN66wLFqo6dz5A9b1dlayP/619LV/CAf5DEgI75mfiiRrBvZVjKa
	 binrd8ap4lYrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34379380AAF2;
	Fri,  7 Feb 2025 12:57:07 +0000 (UTC)
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
 <173893302570.2228053.6566849746266828760.git-patchwork-housekeeping@kernel.org>
Date: Fri, 07 Feb 2025 12:57:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] spi: atmel-quadspi: remove references to runtime PM on error path (2025-02-07T12:21:45)
  Superseding: [v1] spi: atmel-quadspi: remove references to runtime PM on error path (2025-01-27T09:42:58):
    [resubmit] spi: atmel-quadspi: remove references to runtime PM on error path


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


