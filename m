Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 044112075F
	for <lists+linux-spi@lfdr.de>; Thu, 16 May 2019 14:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfEPMzi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Thu, 16 May 2019 08:55:38 -0400
Received: from securetransport.cubewerk.de ([188.68.39.254]:55864 "EHLO
        securetransport.cubewerk.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726537AbfEPMzi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 May 2019 08:55:38 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 May 2019 08:55:37 EDT
Received: from DHPLMX01.DH-ELECTRONICS.ORG (ipbcc19eae.dynamic.kabel-deutschland.de [188.193.158.174])
        (using TLSv1.2 with cipher DHE-RSA-CAMELLIA128-SHA256 (128/128 bits))
        (No client certificate requested)
        by securetransport.cubewerk.de (Postfix) with ESMTPSA id 60F455EE9E;
        Thu, 16 May 2019 14:48:11 +0200 (CEST)
Received: from DHPLMX01 (localhost [127.0.0.1])
        by DHPLMX01.DH-ELECTRONICS.ORG (Postfix) with ESMTP id 061412145B97;
        Thu, 16 May 2019 14:48:11 +0200 (CEST)
Received: by DHPLMX01 (kopano-spooler) with MAPI; Thu, 16 May 2019 14:48:11
 +0200
Subject: Re: [PATCH] spi: spidev: Add dhcom-board to compatibility list
 [Klartext]
From:   "Christoph Niedermaier" <cniedermaier@dh-electronics.com>
To:     "Fabio Estevam" <festevam@gmail.com>
Cc:     "Mark Brown" <broonie@kernel.org>,
        =?us-ascii?Q?linux-spi=40vger=2Eker?= =?us-ascii?Q?nel=2Eorg?= 
        <linux-spi@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Date:   Thu, 16 May 2019 12:48:10 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-Mailer: Kopano 8.7.1
Message-Id: <kcis.7DC7E250415B4C2E9DA25490D6832213@DHPLMX01>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Fabio,

From: Fabio Estevam <festevam@gmail.com>
Sent: Thursday 16th May 2019 13:29
> Hi Christoph,
> 
> It seems that the [Klartext] string is added in the Subject by mistake?
> 

You are right, it has something do to with encryption on our mailing server.
I am in contact with our IT department to fix this issue.
Should I resend the patch when this issue is fixed?

Regards,
Christoph
