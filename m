Return-Path: <linux-spi+bounces-2767-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A268BF4AC
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 04:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E796B280C25
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 02:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8E6EAC2;
	Wed,  8 May 2024 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDH04MRl"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A81A1118E
	for <linux-spi@vger.kernel.org>; Wed,  8 May 2024 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715136028; cv=none; b=Cdf+Roddh3W+ouuDAShfXB31WnCapEt7xPEvwrVCtt0A3RY4luYsM7aVwD+K7vCfMugf1tMQF+ViwXBSADIZ1IXjOrFfqXONc8RV70QzpD3Iy+iLEMeDdtlb6I1HB3qN2wPKIRPc2bTzIWjTq4vxgPxrm303VGjjY1+/BN62BgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715136028; c=relaxed/simple;
	bh=CL0+f65sKBfPYD5zYXIkA1Iowuoxo4Vj0YDxjMc2Bjw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=OSg3ckbBtoYgH94ZZab/PS3t7fN6wmnCVrUtjngmNqrUqjMX4XqBD0MpF5YejKgHqHpc1muqPUyPp9lhwx6uiJvLT7wnnUOnUbRmbjU2ZrxAaXUy9Wg6vQU9JmvwQEILlZuXbqWlHbgfSsZS4521yFupZkNCwpFTCYVPFbZwufI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDH04MRl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D82CC2BBFC;
	Wed,  8 May 2024 02:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715136028;
	bh=CL0+f65sKBfPYD5zYXIkA1Iowuoxo4Vj0YDxjMc2Bjw=;
	h=Subject:From:Date:To:From;
	b=bDH04MRleJa0RniCqB/O+G+xiqkSaykaqulOkjk1IZpTim/Mq98eR14s1kOkazF6a
	 +rup1W+7g7447uf7Oa9oyNolPSctnp9ajnqdeUgvGDniaYjDfmkEOitozyzAu+GLIh
	 wcGOgG5bJxnC2GGU3Z4FvWCPZ/uj6LUQ7Y5CxP4WGfZ4Iprpez2vmGYXUCE4TRA26v
	 qvllBOCQoNY2U9Ou/lg7ZVjKDZTjlKpH+eVccOUJEG7AJ3OG0PyssctqAdx/1zlPTA
	 4bPhF9wT5MFcrNmjEvlQLL5g6B2tvv8dnSvvUBOh4ICnGmu0dM7NUIhZ9sZYOhz+EY
	 LSAbw5XNTM4dw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3127BC43330;
	Wed,  8 May 2024 02:40:28 +0000 (UTC)
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
 <171513602813.19291.7309854173086911501.git-patchwork-summary@kernel.org>
Date: Wed, 08 May 2024 02:40:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: MAINTAINERS: repair file entry in AIROHA SPI SNFI DRIVER
  Submitter: Lukas Bulwahn <lbulwahn@redhat.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=851225
  Lore link: https://lore.kernel.org/r/20240507141449.177538-1-lukas.bulwahn@redhat.com

Patch: [v1,1/1] spi: pxa2xx: Drop the stale entry in documentation TOC
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=851198
  Lore link: https://lore.kernel.org/r/20240507132002.71938-1-andriy.shevchenko@linux.intel.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



