Return-Path: <linux-spi+bounces-1935-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A8E8813AE
	for <lists+linux-spi@lfdr.de>; Wed, 20 Mar 2024 15:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77459283722
	for <lists+linux-spi@lfdr.de>; Wed, 20 Mar 2024 14:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BAC482DB;
	Wed, 20 Mar 2024 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYbTMv8Y"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D18C482C3
	for <linux-spi@vger.kernel.org>; Wed, 20 Mar 2024 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710946228; cv=none; b=XyOCPT/2jSTF1KSKsLrS/4RgZIqolFHvNnQ1gwjXRueTYphpqq9wKuh0wl2RyVkGdZz2Gn9od3+Kg9ob2SG1crqn6tuZbNqKDWiqlU/EemjG0Au3wza6s3Nffiq9Q5XlNB3PSS1p6bZMqF0q8AyBmZC67Xtp18GnU2DkU1IE1J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710946228; c=relaxed/simple;
	bh=SOxg/a8pKo941Avjg18sqy+P4j5ksmMOIMb1auwY4bU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=NoP2SIUE9uYDMA5zSdD5GRjFV01t3EFEWaMPppVNfY3teE/4FwQoG5t8eRxkYQW51syBjkBqHSalnVmonXToecgcdGr4jmnfi4u26SD+biBjwNilb6IFz825RiVJEv7Uo7neAIE3aFM4xzt/2pQDYAhMaNWDJLzp0ShZdE25heM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYbTMv8Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E578C43394;
	Wed, 20 Mar 2024 14:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710946228;
	bh=SOxg/a8pKo941Avjg18sqy+P4j5ksmMOIMb1auwY4bU=;
	h=Subject:From:Date:To:From;
	b=AYbTMv8YS+iYGgMg7DTxZpkD7KU5/WG/SY5MAf9noJVmjOuphhyAfpb045iuZjciN
	 l9fiVddQvqB6hxiIEFxLsruN2IkBmjPx5+nnjhH1TgNZjCEnavEF2t1QaX0+RSFqUj
	 oUID5diawrDsGAF0QD68E0qhMxRNULIdCfk/sdUKiuNxtFRNkU2sHusCYKaq8Ll9Cx
	 9o//XUb5GvpO+xIJkL6u43aDyH2tJwSTO8mA/crd1fbn7Eu9vS22XQTZ+DherL9fFE
	 o3bWDsC2cQqNUww3GtZjn+8l1PhMyu5xnmlIL5OJap+TQMVEfmAozmPh9fxOuKJ0Cn
	 MZhP95GESP6ew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14CF3D84BB0;
	Wed, 20 Mar 2024 14:50:28 +0000 (UTC)
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
 <171094622801.18599.12295530570579833606.git-patchwork-summary@kernel.org>
Date: Wed, 20 Mar 2024 14:50:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: docs: spidev: fix echo command format
  Submitter: David Lechner <dlechner@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=836516
  Lore link: https://lore.kernel.org/r/20240319183344.2106335-1-dlechner@baylibre.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



