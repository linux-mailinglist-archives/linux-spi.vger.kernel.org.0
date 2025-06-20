Return-Path: <linux-spi+bounces-8687-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3ED2AE1C37
	for <lists+linux-spi@lfdr.de>; Fri, 20 Jun 2025 15:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FBE01622F4
	for <lists+linux-spi@lfdr.de>; Fri, 20 Jun 2025 13:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2285428A735;
	Fri, 20 Jun 2025 13:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZw74LrZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE90014F70;
	Fri, 20 Jun 2025 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750426190; cv=none; b=OF4oFprBONNfZtKUzvXodUQ85hBHZYjyiIscHT7iSRG6RBgob35g495WR8xbYYq5pATvtl6InI42dezAQ5AU28lwPMrKeGARzzsf6Zn/H3FRXNGPSfDIuNXz9E/XO/6IXbcZL/yVngZmWXTcA6kAtkcnqGDpv9CmgsP95Wq4YnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750426190; c=relaxed/simple;
	bh=p5Ufv1TFFM1FV36bMMoazXSDbE8YqDKoOsYCT0MDLKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mDSQocR1Gx/lej6usSXYhId6CZ5yV3TWeE9QDtUynbpbcpLCQYv0gbxs52MFANqu5voKAyW3czQcmJNY8DOaRa8Ik+28cA57vUo6YAP3T6dhl6L1q3icfYqEernLH/+RuXyYVfKr25S/fN+d9gg0+nNLcdCeE15k0jRPy7oi/ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZw74LrZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3603DC4CEE3;
	Fri, 20 Jun 2025 13:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750426189;
	bh=p5Ufv1TFFM1FV36bMMoazXSDbE8YqDKoOsYCT0MDLKA=;
	h=From:To:Cc:Subject:Date:From;
	b=gZw74LrZPbfmrhWxXZZVLPKvBy77a4YPbMrrWoNXfEx9cYatV8TEAy8xJCEDUXE6j
	 np2Q45JMnX+aVXG/wlIf9p/N3x73pJWPHlX3+kwWgioOXPnD+6dEvfRc7OmLIHHnG5
	 41HuLphW6btbxvfrUuE2d5bal7vJSTDR4sxxa9epoCbLIoztNCOsFLEzLsDx7D6ItX
	 Lski2X0JiI4zYdQm79HjhzNRF9FIF4JNgqxmsF+TmYm6xQAwhiVYLohexUS8qLlKDV
	 gGXr9nKwy2q4sxNKMTfoIXlpPoCgF8M7HOiF9lAFqCagUv9ZzFqAM8avCEZZvBKxHr
	 3QJ0PxDWGV91Q==
From: Conor Dooley <conor@kernel.org>
To: linux-spi@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] spi: microchip-core-qspi: Add regular transfers
Date: Fri, 20 Jun 2025 14:28:23 +0100
Message-ID: <20250620-finer-yoyo-0bcae988a299@spud>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1322; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=VxYKvNcOZ2ns/rqgbWI5MCvjyTgefftsav02NvsMkOw=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDBmhid8PZ346vMZAko/hqVxkXfv9GRqXFzlpRjR+vT/FR e3hy8ULO0pZGMQ4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjARFnuG/wVNeQdq3bSLuyb3 5nsKWIsHT4q5y/rnKO+1wKZdiuJmBQz/NK3qgv99+dq6fU6pRmfQpKpS7a8Tk928tgZkTFm72Xg fHwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Hey,

This is a v2 of a patchset I sent about this time last year, adding the
regular transfer_one_message op to the microchip-core-qspi driver. In that
v1 Mark expressed his dislike for that op, so v2 is using
prepare/unprepare/transfer_one instead. The unprepare implementation still
contains the 750 us delay that the driver had back in v1. I've heard a
suggestion internally as to why this is needed, but it was unsubstantiated,
so I still have no justification for it. I held off on sending a v2 because
of a lack of explanation for the delay, but I don't wanna hold off forever
for something I might never understand.

Cheers,
Conor.

v1: https://lore.kernel.org/linux-spi/20240612-brigade-shell-1f626e7e592f@spud/

CC: Conor Dooley <conor.dooley@microchip.com>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Mark Brown <broonie@kernel.org>
CC: linux-spi@vger.kernel.org
CC: linux-kernel@vger.kernel.org

Conor Dooley (2):
  spi: microchip-core-qspi: set min_speed_hz during probe
  spi: microchip-core-qspi: remove unused param from
    mchp_coreqspi_write_op()

Cyril Jean (1):
  spi: microchip-core-qspi: Add regular transfers

 drivers/spi/spi-microchip-core-qspi.c | 226 +++++++++++++++++++++++---
 1 file changed, 204 insertions(+), 22 deletions(-)

-- 
2.45.2


