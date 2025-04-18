Return-Path: <linux-spi+bounces-7670-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FFDA93173
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 07:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDDC77AD6C7
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 05:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3A0267F42;
	Fri, 18 Apr 2025 05:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPrSxOBP"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650C3209663
	for <linux-spi@vger.kernel.org>; Fri, 18 Apr 2025 05:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744954197; cv=none; b=cnlgDkNg/aNkVJp1uJ7nmJiRC0Oef9+4VJZOxZycKmMYTYN8DWJT8ECrcbpwMNtNaNMMU1tLC1Dev77liG0ag16krgzfn+5yH2qVvBf41Ky+u4z6LrCtSmnbrBEhjt2HlRyOQb8wMDsavD+xcGq7Ho6RAggIrNjsjamzqmJq0w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744954197; c=relaxed/simple;
	bh=i2wKdn8KXfIJodbxkbyWilin1fWxMj8QL9OswVFjqH4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=rvvxng11RRacS3ty4t5rMrP8PkcoF1b8qz4wYNnGPkA60/e+v1Y0o9JhjOuB8BMqc845eb6neUxj8lS3bzFQbDmln0/tf/o8B6e2misJQxlN9RdvvLCrUiIWQfISf+NzP+M9IVvAgMKK7o0vZ2kYDHdTB/xIUFRMpf4rudawri4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPrSxOBP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C74C4CEE2;
	Fri, 18 Apr 2025 05:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744954197;
	bh=i2wKdn8KXfIJodbxkbyWilin1fWxMj8QL9OswVFjqH4=;
	h=Subject:From:Date:To:From;
	b=jPrSxOBPolyP4/6lz1ljjw1DeTHYcT+NqYBdIBqdtHriUd61GLQAvEDCv9p0HqrLs
	 tMmSNAE3B3N8cNCaGcm8VHQwfYs5Vc/R3chrIu0ek8sYM9sdo8OJdPkZAXnglXZeMO
	 lXdS1tli6zIlgClmKagB+nOeum8V5sVtgb1YX1WWH7hgW4jtmnvTkMyexe6zVWnriT
	 mzOm6BI9HqZO6COhfIuXbSmKCGpqVl8x38/os+hcyHN4Yos75K6BS/a1KhuRHd7xQZ
	 nRVPm7I69AApd3tLXLlaTHj+k0FqObwXWjRkq6u+6ZyL+Ot6rdDjVkLciWCXV6UdIH
	 aXIIxNffYisCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 76811380CFE9;
	Fri, 18 Apr 2025 05:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <174495423495.117307.9364963000439396794.git-patchwork-summary@kernel.org>
Date: Fri, 18 Apr 2025 05:30:34 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: Introduce and use spi_bpw_to_bytes()
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=954541
  Lore link: https://lore.kernel.org/r/20250417152529.490582-1-andriy.shevchenko@linux.intel.com
    Patches: [v3,1/2] spi: Add spi_bpw_to_bytes() helper and use it
             [v3,2/2] spi: dw: Use spi_bpw_to_bytes() helper


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



