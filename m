Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD1B39459D
	for <lists+linux-spi@lfdr.de>; Fri, 28 May 2021 18:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236832AbhE1QG3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 May 2021 12:06:29 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59344 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236835AbhE1QGP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 May 2021 12:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SBXNMYitbqet/X03PCiNCJF+F+GKK5Ot8K0px9rwQbE=; b=G+P/Tg9lzzagBL2+OwaDdEJ1yf
        gmOtVtMMyL7wy34upXbVwuQc1XkvDQDTtiRUzPwmyTcu0C24LCZPszJejIdO3tE8myPsyF6vfyMtI
        hW52xz/hUc5tDWUa1RLjeErOoq0Sg1TQUJUKigiOICj4DMKYpLYFWJxBY9ASjNIYmJr4=;
Received: from cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net ([92.233.91.117] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1lmeyD-006czW-Vt; Fri, 28 May 2021 16:04:22 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 5CD4ED07916; Fri, 28 May 2021 17:04:21 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Mark@sirena.org.uk, Brown@sirena.org.uk, broonie@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v1 1/1] spi: Enable tracing of the SPI setup CS selection
Date:   Fri, 28 May 2021 17:04:20 +0100
Message-Id: <162221783258.3504827.17153744929940659898.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210526195655.75691-1-andriy.shevchenko@linux.intel.com>
References: <20210526195655.75691-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Mark Brown,,, <broonie@kernel.org>

On Wed, 26 May 2021 22:56:55 +0300, Andy Shevchenko wrote:
> It is helpful to see what state of CS signal was during one
> or another SPI operation. All the same for SPI setup.
> 
> Enable tracing of the SPI setup and CS selection.

Applied, thanks!

[1/1] spi: Enable tracing of the SPI setup CS selection
      commit: 5cb4e1f33e5eeadbce3814282e010d4dd31816af

Best regards,
-- 
Mark Brown,,, <broonie@kernel.org>
