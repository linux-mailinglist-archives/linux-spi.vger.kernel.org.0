Return-Path: <linux-spi+bounces-1167-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7686F84CD70
	for <lists+linux-spi@lfdr.de>; Wed,  7 Feb 2024 15:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A437D1C23A27
	for <lists+linux-spi@lfdr.de>; Wed,  7 Feb 2024 14:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2227F471;
	Wed,  7 Feb 2024 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8A9BQyV"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270347F46D
	for <linux-spi@vger.kernel.org>; Wed,  7 Feb 2024 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317797; cv=none; b=Vpquui1D9GPoXFZdEveJZNvyjzZdPOf63W+GJ3oKauDHi97nHgaqFizvsR6pepIKg8svmLxDfLTWmeFSzpMnmZwQ798zxfDVEHnO1LXyETYnhm8EKIypHEGad17ZjwhEMs4hf2tD/c5gAycqNTvye/O09q8a7Wk8cU5fIWUb/6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317797; c=relaxed/simple;
	bh=yrsZIOJluIsf56mHi3pFu7cTaUHmM5biKd8PjxyWfo0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ZYiDmd0mzygIxLKMxOglDOoRnFGppLfU+D59uC0CwE3A6DOipY8q0vA60vt9dUFQ5W/6FLqQBseAbrbt2ZYAadEiAqKrKlzfu2psDhmDgkfLeU2VNc0lyKednPhqVjieEcCSXfIMKrWmMzg6XQOJvGymdwJt/cUyoXQj3/igkmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8A9BQyV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91E53C433C7;
	Wed,  7 Feb 2024 14:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707317796;
	bh=yrsZIOJluIsf56mHi3pFu7cTaUHmM5biKd8PjxyWfo0=;
	h=Subject:From:Date:To:From;
	b=C8A9BQyVT2b2KTQn2US8uaP1K0RsEpPXKU9OxQPlz/JmUufIYepuGi/iulaV3QhdC
	 95nhQupQpc0RTb9/3leWG9JWLhzYepQ5l5kVKmbtj+Vnko4lwgSZd5zQTnBt57xxDm
	 wLbnSOwdNLcyW0lF9uHI99V9d3TRvGi6C859zZa2w0TloocENJECpCQuEToonU9yhR
	 c7FduxPaHneMzobWZmrOJ/SCRC2L2b7zUI0aXHZTOshT/BDrNVkdK3GPDXBKx/PPuW
	 bxG9eNOA0gTzyaqpy2wmyQW/M9wtZORe3WHcapQWqgkf0vOp5khjtygSJYqTPvh0G9
	 rzIPKHpoQOIMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78FD9E2F2F1;
	Wed,  7 Feb 2024 14:56:36 +0000 (UTC)
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
 <170731779649.29441.11405122990047434456.git-patchwork-housekeeping@kernel.org>
Date: Wed, 07 Feb 2024 14:56:36 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: axi-spi-engine: performance improvements (2024-02-07T14:51:23)
  Superseding: [v1] spi: axi-spi-engine: performance improvements (2024-02-06T20:31:26):
    [1/2] spi: axi-spi-engine: remove use of ida for sync id
    [2/2] spi: axi-spi-engine: move msg finalization out of irq handler


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


