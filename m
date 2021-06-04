Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823D939BD30
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jun 2021 18:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhFDQe2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Jun 2021 12:34:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229959AbhFDQe2 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 4 Jun 2021 12:34:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C62261153;
        Fri,  4 Jun 2021 16:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622824362;
        bh=0pyBbHebHavMSIgnjzBumaMQcmnqDSMG7t3lC1FX+3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SuJDK8f4MpYMvJ8/f1MWcDO3waTdi4ICNCMWwgdhhanxEQmWGZmndUyrv+z0hRUE4
         uMBurWfxvz6jyWGNFjAd1q6AIlCXdkZ+l6NWnwz7R7NfiAlHBdYNM8kxeQwtfcbP8a
         cEl6Tuqp63emC7SZpm2jJFyO5sQIYcMLiCtc9eYjlU3bezhtQ0WwDq8sEQVDD9n+MA
         eUH6a1bq28AgFAfEDt92ziO3ksrT/TuvccHedtLdBDiL1pZtFpIG4KQmhBb5uaEoFe
         0SPxJLCnxfB8iOt24iEqGrxTsWrzY4KAENj8wnNj9S3a+02PrRWabJNx4wTkCzvFCB
         CR/XxEQN64dTg==
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        patrice.chotard@foss.st.com
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        christophe.kerello@foss.st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] spi: stm32-qspi: Fix W=1 build warning
Date:   Fri,  4 Jun 2021 17:32:24 +0100
Message-Id: <162282433425.39122.14560975915714182351.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210604075009.25914-1-patrice.chotard@foss.st.com>
References: <20210604075009.25914-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 4 Jun 2021 09:50:09 +0200, patrice.chotard@foss.st.com wrote:
> Fix the following compilation warning using W=1 build:
> arm-linux-gnueabi-ld: drivers/spi/spi-stm32-qspi.o: in function `stm32_qspi_poll_status':

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32-qspi: Fix W=1 build warning
      commit: 6829222b408f5aa5222c18ea3f492cac19fa9405

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
