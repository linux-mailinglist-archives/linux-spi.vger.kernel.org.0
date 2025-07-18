Return-Path: <linux-spi+bounces-9125-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C217FB0997B
	for <lists+linux-spi@lfdr.de>; Fri, 18 Jul 2025 03:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77744A459D1
	for <lists+linux-spi@lfdr.de>; Fri, 18 Jul 2025 01:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7033518A6AE;
	Fri, 18 Jul 2025 01:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWGOtOe3"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C00E18035
	for <linux-spi@vger.kernel.org>; Fri, 18 Jul 2025 01:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752803928; cv=none; b=G06O6mWY7s8V6Eodq/SI0CHqRPSik4umc4EqptUIKuGCC9xNktl1/NSxXBAZTQwQJD7E2m7XOFq/fXBTyXQMoz3pxOt0fIqOrLBXCuepXGR3srYb/Y8At/ArePTB56Iv+V7uqq+mmCivaVIyR1EAPAYdjaIiC7wF5c4FMlbujUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752803928; c=relaxed/simple;
	bh=Vu44C8tCACaMC+XBMWxH83g736QLMdCoABGWDeJE8mc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=RzSrbI3JGoyDR/6X7n8dyuW51PBoI26vGlIB6yjnKRkvS1V6SrkUDsNF9DN8no9hvOzdQ8Jl9++FsHLDsiwyaNArowx6U+6dXqWpiyKKZmQigkTOrfvF7JYwQZErSZGWiGQn2+52dauH8oMH/xAw2LkTfwPdIsSBfgo1xgUeCBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWGOtOe3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B81C4CEE3;
	Fri, 18 Jul 2025 01:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752803927;
	bh=Vu44C8tCACaMC+XBMWxH83g736QLMdCoABGWDeJE8mc=;
	h=Subject:From:Date:To:From;
	b=fWGOtOe3dRDpKYSvMtvd+ZQZMpODxeyG+YjGlhvwVX7F/PTjOwUeT3uFR0z7GF9U5
	 xvY7jEI9SRE+wtM5rPkIEWrpSVD90XsKp3ay4qiMO7DgGIVaOD+C1zjZLFGgBzhn4H
	 cct6yV9Aq96AQ9trtaQMIOpqj7h2LuxjP+NIVBg+hbSC0EGKK8YAPFSVsMY0exa1oW
	 qChWgECNcnxAsu7NUWrjCj7i8OFo42FhMvHpoT0Y9oog4RXc6TFkFgXm1v7cpvaXiy
	 KFj3fKi1Qf4/0t6RH6gl+zPwQJK+warBIyPSC6LkQOtoW/unyQtdEfxFFS+3Y/7vHL
	 lluenyA6540DA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD4D383BA3C;
	Fri, 18 Jul 2025 01:59:08 +0000 (UTC)
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
 <175280394749.2141049.3859569590790932368.git-patchwork-housekeeping@kernel.org>
Date: Fri, 18 Jul 2025 01:59:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] support for amlogic the new SPI IP (2025-07-18T01:52:16)
  Superseding: [v4] support for amlogic the new SPI IP (2025-07-04T02:59:31):
    [v4,1/3] spi: dt-bindings: Add binding document of Amlogic SPISG controller
    [v4,2/3] spi: Add Amlogic SPISG driver
    [v4,3/3] MAINTAINERS: Add an entry for Amlogic spi driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


