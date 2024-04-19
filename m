Return-Path: <linux-spi+bounces-2438-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AB38AAC9B
	for <lists+linux-spi@lfdr.de>; Fri, 19 Apr 2024 12:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AF26B22110
	for <lists+linux-spi@lfdr.de>; Fri, 19 Apr 2024 10:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA98678276;
	Fri, 19 Apr 2024 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVccohpM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A3974BEC
	for <linux-spi@vger.kernel.org>; Fri, 19 Apr 2024 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713521427; cv=none; b=irIsaNqyq59JYuq7TRVG8EVrOfGk8oLGQDrEl1xvm4dYp2wrG8syYGm2Zp5H63B6dY6eVIlHBImCDZEx+dbgX2uRVMyZfHvoSBcDQmvfCOPdhJQFqcKuA96hIEF0JIA8iyBwZDNOXlL7xkDx4UMAr5OY7M66oiBYiDtaBfZfcsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713521427; c=relaxed/simple;
	bh=PKK5M7aCNEoeSAvVBLXBRb2D8+v4hE6r9xBH3PtRNJo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=bziGR10aVhZxpZ0+aGGiyhyppD2pWGW2s8pQrFsfo1tF04CEbNGXgZqbm+U/SBx7YhIKGtM6tpRCcCOT/d3y+EWRoeWwamD6h7JkBUeOlBeJooi/zmiUv4ZQlFpdz8QJcalXKWgBtfxQ8SvsLXAKIMRB0eQh2uCy6s4jezw+AA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVccohpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D826C116B1;
	Fri, 19 Apr 2024 10:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713521427;
	bh=PKK5M7aCNEoeSAvVBLXBRb2D8+v4hE6r9xBH3PtRNJo=;
	h=Subject:From:Date:To:From;
	b=dVccohpMZi+QtmUQoPSA9zqbKlaWkmeFl/CuTfSM9MZ+qiE7s9lHi4Qhj/vVXSHtu
	 9TKmWSWsjcKKrV3aOO6bzbw8LlCnGnR8jA3nXFewVow5onetYoX+wWDO/DFxVw+CHZ
	 6NvZyWGUNQYYh66HbWlGqBNJ/2uWwgAJsZIhy0aqragnLEv8R+k4ZFRbSHYxoYqr4C
	 r1JUXCeDw3CLs6EKLI8eZypnPGgfRXfj3B50u2aTL56I9MTfcq8VT1K3+RHcZls08E
	 TV07fFuMRSkaxcBDGrwSCN8CiMn63VsLrHLkdynwRWgs9HVjqw0AJTQjQ6kSUbtto9
	 qry/7qBD4DfVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E2E4C433E9;
	Fri, 19 Apr 2024 10:10:27 +0000 (UTC)
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
 <171352142719.24371.2236600083310683898.git-patchwork-summary@kernel.org>
Date: Fri, 19 Apr 2024 10:10:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] spi: cs42l43: Correct name of ACPI property
  Submitter: Maciej Strozek <mstrozek@opensource.cirrus.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=845746
  Lore link: https://lore.kernel.org/r/20240418103315.1487267-1-mstrozek@opensource.cirrus.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



