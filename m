Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C60BB186D32
	for <lists+linux-spi@lfdr.de>; Mon, 16 Mar 2020 15:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731592AbgCPOgy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Mar 2020 10:36:54 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:5362 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731539AbgCPOgx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 16 Mar 2020 10:36:53 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48gzQW4QWXzw;
        Mon, 16 Mar 2020 15:36:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1584369411; bh=f5htLhfCd7N4D3wsFW747vB6i1c6uFwRsy6sMhNEEcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OwPCRQAd0dzCuyPRvMUWeVuw6YUMGyKGHyC0PPwMxAstizMu+ETg/gyR5GbsPMNDg
         nUsReNXR0+i0JmRoqZlfigr82MxTfpTjkXhHwzUl3UetY3DvsdG//SU3fX/uGQiAtu
         WpZUxbko1al/UPmL9O2rKc+rHTMQterMe2dNAcaRQtauPKpXNA0NYEf4CMMdbpSfvW
         xdH5pftJ4V8ZUKCvIAkiDFEt59OE4tUWUiYdTF518d6DGZRlBc6zliTYpmvTaMam0I
         LAcPW/IlmvFetkk6SjCPCvpX3UY9pwh0toS/Li7cnTagvuaE8Wi+oqPdfhVjYkkAT/
         ahvG0qd0FBFYA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Mon, 16 Mar 2020 15:36:50 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Wenyou Yang <wenyou.yang@atmel.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: atmel: Fix cs_change inversion
Message-ID: <20200316143650.GB19141@qmqm.qmqm.pl>
References: <1ca2cf159f77a49acfd787f856d44a2aae8d24fb.1584291526.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ca2cf159f77a49acfd787f856d44a2aae8d24fb.1584291526.git.mirq-linux@rere.qmqm.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Mar 15, 2020 at 06:06:51PM +0100, Micha³ Miros³aw wrote:
> cs_change for a transfer means to affect the chipselect line. The driver
> inverts the meaning of it for last transfer. Fix by correcting keep_cs
> values.
[...]

Please disregard this patch. As Mark Brown pointed out, this inversion of
meaning is actually intended.

Best Regards
Micha³ Miros³aw
