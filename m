Return-Path: <linux-spi+bounces-965-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4880D845943
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 14:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB47F1F2731A
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 13:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C7A5B669;
	Thu,  1 Feb 2024 13:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htxCIa8T"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CB23A1BC
	for <linux-spi@vger.kernel.org>; Thu,  1 Feb 2024 13:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706795424; cv=none; b=OzFMd8eJmWHpQRWvt5UHUcy3SwPq6O0P4AG5hJ8IOBvxC0IBBM89tRo/pZ2cnCzDYRdMPxFKGRID5smHe4STlUzrvenBMP3Q0AbMdQrLECPQKYe0fIjBxYZopMR+HSstafn8Uw6H6rRudQcr9ZQbIsZSSF9Os/lUjEStoXhNrZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706795424; c=relaxed/simple;
	bh=jbVy8VmG3/8ZNyv8EIkyIGZQp/mHiv+K5XJsMbKEmm4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=BxrU3tKtvnQ7PJmsVv+0LJ+lk+TyO8sjnsBsn0i6mWYxUaBi5J5B8HTI7i0Fb2au27PQUzvLhF9QmiGfkzNkknpraoXIp5++tyzadupGf1WX7AKuz8C0QmjsU9O2EMBywpTM0z1T+IDUsYTO4TrPHv5fvwIaFkR0ePAYzMmo2W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htxCIa8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 456FEC433C7;
	Thu,  1 Feb 2024 13:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706795424;
	bh=jbVy8VmG3/8ZNyv8EIkyIGZQp/mHiv+K5XJsMbKEmm4=;
	h=Subject:From:Date:To:From;
	b=htxCIa8TO5AL4WeE7zOW2St8mpXVExlYEDDLQ+rsubtFTByG+R1tFa8z+jt3y9lXt
	 Io/HEuuFJZ5lcXV+6CTmGw1uGeEoiwvxKFnB7i35pY+ws6yR8yJNaGkVPicc0Xo2XF
	 CV8IP//fE1yzKAueqTK+EuXvTDzxuKmfXb/7uYJfIyXW97Sn9FMkMWv1a1JxjWzwv2
	 sgacgw/6UydlAkfxzr/Pdy77dUslvVN7ybZ8qhU+zx7EtW9KrIRhMPa95rrv8lp2IQ
	 dgg/r+JdC27eeTPpXLQJ5g4q3LDToBb8YKhZYVr9citgexmGYaWTFw8kKUh2kjgcAR
	 fQIXn1HHEDqnA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22985E3237E;
	Thu,  1 Feb 2024 13:50:24 +0000 (UTC)
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
 <170679542406.24842.18178954354076682821.git-patchwork-summary@kernel.org>
Date: Thu, 01 Feb 2024 13:50:24 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: reorder spi_message struct member doc comments
  Submitter: David Lechner <dlechner@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=821807
  Lore link: https://lore.kernel.org/r/20240131170732.1665105-1-dlechner@baylibre.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



