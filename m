Return-Path: <linux-spi+bounces-11472-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6583CC7F712
	for <lists+linux-spi@lfdr.de>; Mon, 24 Nov 2025 09:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 549774E3916
	for <lists+linux-spi@lfdr.de>; Mon, 24 Nov 2025 08:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BF62F12A2;
	Mon, 24 Nov 2025 08:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfLc5oGu"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95F02F12B6
	for <linux-spi@vger.kernel.org>; Mon, 24 Nov 2025 08:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763974677; cv=none; b=DSh5I4hqnZsXIuXtGxzLrUSNwHLhb6qcx6jtiaRhpzqTsjdbqTXrrqf3r/cdNr0weRNvfgQh04uJWAIRTy+DIQjLgNgTl+iSSW57SUzzqz/X2Nz1XdFftiMBX7Udttlz1EhS3uTsjcSpvkuzU+6K53OPHCEzre7YDyUSX7tBVKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763974677; c=relaxed/simple;
	bh=5vVqT1Z2sArPScA5CpyAeHnDvh7Qt4ssjvYZi2rAHOc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=hu/KpTOtEX8nY4zzBtsUNVhsde6sQ1y8s13r7sXAdPuxR1V/TSfQJDd+jx1B5eDTOn5crBw6DfFfzsiGT9zR3FBPlH7fS9iyLLm5iMqBpcbnsVgm2Cp8m52CXMpz3KTHFUX+xVEBmV4FL1XhoII0YuiYp/VOM6cDBKf/N6VX3JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfLc5oGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D31C4CEF1;
	Mon, 24 Nov 2025 08:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763974677;
	bh=5vVqT1Z2sArPScA5CpyAeHnDvh7Qt4ssjvYZi2rAHOc=;
	h=Subject:From:Date:To:From;
	b=BfLc5oGuPMDyN8v9Xx89ra6V93V+vpPdLJqZK+NcysULSPxQlnEZC5+V1+vtkn7DM
	 Vsi9//gqSwbVhPKV+zoiymap3THaWIRRu82AsU62lzotpuuP4IVJxPiN2kkdoudADd
	 Bqd6GEVGbEcCEojvd+5X75qhYT2H5FL6TNFMh6CIdl4X2QqzjP8ulD4SV7CMKPzCVp
	 Sz9kzUTvw9Mk61KDIRj9DtzzEPfvwATdZxf+qIFP+JILDCir8EaEpxtFMjPHZFDOx4
	 6NWikza3jzLrgevgmIXQHVo+263cgQ/C9aZTQ23XSYhY5CkgfBQh9ux1F8al3v4oTN
	 zYF/cCozQJaxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 750E13A8624F;
	Mon, 24 Nov 2025 08:57:21 +0000 (UTC)
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
 <176397464002.3636277.4462968061152192057.git-patchwork-housekeeping@kernel.org>
Date: Mon, 24 Nov 2025 08:57:20 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: Fix potential uninitialized variable in probe() (2025-11-24T07:56:01)
  Superseding: [v1] spi: Fix potential uninitialized variable in probe() (2025-11-21T13:35:01):
    [next] spi: Fix potential uninitialized variable in probe()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


