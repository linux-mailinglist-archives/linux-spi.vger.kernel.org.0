Return-Path: <linux-spi+bounces-8667-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6660ADF82B
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 22:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 491D14A0ED4
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 20:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E59A1B78F3;
	Wed, 18 Jun 2025 20:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjU82PtX"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18665219EAD
	for <linux-spi@vger.kernel.org>; Wed, 18 Jun 2025 20:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750280170; cv=none; b=olNeBwDYn6JyZGCCEgD/oT3cDAIz7UGPEsFF2WUdmclf97VJbjtAbmWPGIrbkCCNGAcnc5sclOwYBSAwVuK2cvl6ZL/KPJQBtDY0BHtCR3cR6gtnbLt5OoINlFWKr63AXtzpCuMJaplLtBdWtxeqmBOBDoOzOOqGZrFz7q8pfOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750280170; c=relaxed/simple;
	bh=YlyX2z9D0APvc8fH/crMgCg8643Dc9f0BYtZQbyIbM0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=aUwC+pOLk+VzqT7T5mVEyh47ne4OcdXQBxDH+e8yYAx8U8lU4fchGR/dioiDCUEPImyUC6ztNbo7l4py2/4Jw0xtxHfdqx1qZkxq2zkCh8q0anVnI1gsmKpVywqKm0QAErWwI6bxi8Pk7xfU/5NiLIV6aJuVE1e9ViZfOxUB2sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjU82PtX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9F3C4CEE7;
	Wed, 18 Jun 2025 20:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750280170;
	bh=YlyX2z9D0APvc8fH/crMgCg8643Dc9f0BYtZQbyIbM0=;
	h=Subject:From:Date:To:From;
	b=VjU82PtXQLA/ylzLogh9yZ2UCCicJW/SLkqnv6AdD2Z8wVDCxnvOGwmJuUl7+tcV+
	 l6jpEHFKbeCKn6o60roz2ZBAdnmGxS4iEQx6YiIg8xo0lIBmG50IOmCz5youJqGZJl
	 yoyP9xJkZLDJ8QNN6viJduIRvTmtwAk/5qsBA9nU5d44lwUP9bPP82brCI0yW98fyw
	 AkQMCua6dbGXGAaI0xToKb8N/ym+zeGxx0Sm6yB92BJzKRdEnX9za958CEI2eZRpNy
	 Oi0DwLG3lD9QbTDZeRXJwHb35Lz3SHrgIVtE8ybbpFDy3SY6T46XhrlDOggeGqZfoX
	 8qi+RqA5LLYpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DCA3806649;
	Wed, 18 Jun 2025 20:56:39 +0000 (UTC)
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
 <175028019794.253276.388862016232699271.git-patchwork-housekeeping@kernel.org>
Date: Wed, 18 Jun 2025 20:56:37 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: spi-qpic-snand: avoid memory corruption (2025-06-18T20:22:48)
  Superseding: [v2] spi: spi-qpic-snand: avoid memory corruption (2025-05-29T17:25:09):
    [v2,1/2] spi: spi-qpic-snand: reallocate BAM transactions
    [v2,2/2] mtd: nand: qpic_common: prevent out of bounds access of BAM arrays


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


