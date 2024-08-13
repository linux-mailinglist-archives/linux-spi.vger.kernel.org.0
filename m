Return-Path: <linux-spi+bounces-4175-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920EA95089F
	for <lists+linux-spi@lfdr.de>; Tue, 13 Aug 2024 17:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E022282F5B
	for <lists+linux-spi@lfdr.de>; Tue, 13 Aug 2024 15:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5CB19B3CE;
	Tue, 13 Aug 2024 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fnjt/5sD"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C541E4A4
	for <linux-spi@vger.kernel.org>; Tue, 13 Aug 2024 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723561884; cv=none; b=Qc47kOL0rBudsSckb0hWWfDJACwDi4I7V4HrVeV+HQEBq+tgLW1nnklPb2uSvtuuyq8Kt8sQqB3GPOI4F3MHmKk7EvJ03HYgJ2REOYfxzBI9BsfTacko6p4B7/UFDOnBwhAnJPP6HMNX7hQQEctz6XS8/eYZvhJ31mJviWgOfhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723561884; c=relaxed/simple;
	bh=ksloM+vsDt8OKSucLzRnd4skPXfXMBU0EGGVmAosUxM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=OcyPrcduklwC4KVhB5swNnZu4+WrQoEors4wFKqi8Ym7FUocMndJqvomfiAHYaglvHVMns5izrNt6yApgieLLSRzno+FvEwJo3ppm84A6UCF4ziHZEASADVbmFIur9Nt2USpqlMDShbZLOwZctkxGGuFbyS7psCLdHnKm49wb/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fnjt/5sD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E38BC4AF0B;
	Tue, 13 Aug 2024 15:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723561884;
	bh=ksloM+vsDt8OKSucLzRnd4skPXfXMBU0EGGVmAosUxM=;
	h=Subject:From:Date:To:From;
	b=Fnjt/5sDgOWP3YZVlVNhiQs4yxscL7byia/021HQgVn3oCFwcFmhFXpDORroF+ENZ
	 EFae4llH8yzPhsTZN54kurD5UrPbywSaC31HfW7EqrEy/C8NroYC/9V/TpvGuVMQxz
	 X59crcFWIRTUVJT/7ZgtepiK5EAjHnqBJHFQH3IJzeTLNuTgetFsZkyZsk11hPj3es
	 1GAtqGmM/QcpY72Px/QvPg8xTDAAO5JCoHhwTFhBPOoOLhpeZEINvF2gsnzEMqZCYj
	 cjXlnXwkDW1YhBTYk7IueZWxV2bXXuueEZMSUmSaJxXh6VIge6uWwAEwAsL535y8d9
	 O1SOvNW3YH07Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3E21D3823327;
	Tue, 13 Aug 2024 15:11:24 +0000 (UTC)
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
 <172356188278.1664936.8825839956050228933.git-patchwork-summary@kernel.org>
Date: Tue, 13 Aug 2024 15:11:22 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: ALSA: Add support for new HP G12 laptops
  Submitter: Richard Fitzgerald <rf@opensource.cirrus.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=876273
  Lore link: https://lore.kernel.org/r/20240802152215.20831-1-rf@opensource.cirrus.com
    Patches: [v2,1/3] spi: Add empty versions of ACPI functions
             [v2,2/3] i2c: Fix conditional for substituting empty ACPI functions

Patch: spi: zynqmp-gqspi: Scale timeout by data size
  Submitter: Sean Anderson <sean.anderson@linux.dev>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=878349
  Lore link: https://lore.kernel.org/r/20240809201540.3363243-1-sean.anderson@linux.dev


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



