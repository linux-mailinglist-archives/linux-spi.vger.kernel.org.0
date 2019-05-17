Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 259CD21934
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2019 15:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfEQNdc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 17 May 2019 09:33:32 -0400
Received: from securetransport.cubewerk.de ([188.68.39.254]:55366 "EHLO
        securetransport.cubewerk.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728333AbfEQNdc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 May 2019 09:33:32 -0400
Received: from DHPLMX01.DH-ELECTRONICS.ORG (ipbcc19eae.dynamic.kabel-deutschland.de [188.193.158.174])
        (using TLSv1.2 with cipher DHE-RSA-CAMELLIA128-SHA256 (128/128 bits))
        (No client certificate requested)
        by securetransport.cubewerk.de (Postfix) with ESMTPSA id 2613A5E973;
        Fri, 17 May 2019 15:33:11 +0200 (CEST)
Received: from DHPLMX01 (localhost [127.0.0.1])
        by DHPLMX01.DH-ELECTRONICS.ORG (Postfix) with ESMTP id C793B214560A;
        Fri, 17 May 2019 15:33:10 +0200 (CEST)
Received: by DHPLMX01 (kopano-spooler) with MAPI; Fri, 17 May 2019 15:33:10
 +0200
Subject: RE: [PATCH] spi: spidev: Add dhcom-board to compatibility list
 [Klartext]
From:   "Christoph Niedermaier" <cniedermaier@dh-electronics.com>
To:     "Mark Brown" <broonie@kernel.org>
Cc:     "Fabio Estevam" <festevam@gmail.com>,
        =?us-ascii?Q?linux-spi=40vger=2E?= =?us-ascii?Q?kernel=2Eorg?= 
        <linux-spi@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Date:   Fri, 17 May 2019 13:33:10 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-Mailer: Kopano 8.7.1
Message-Id: <kcis.5C13FC60CCD74BFBA12983C9AE17B46E@DHPLMX01>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Mark Brown <broonie@kernel.org>
Sent: Thursday 16th May 2019 18:20
>
> On Thu, May 16, 2019 at 12:48:10PM +0000, Christoph Niedermaier wrote:
>
> > You are right, it has something do to with encryption on our mailing server.
> > I am in contact with our IT department to fix this issue.
> > Should I resend the patch when this issue is fixed?
>
> This is already the second time you sent it today, the other time didn't
> have this problem.
>

Thanks for the info, but unfortunately only the email with "[Klartext]" went to the mailing list.

Regards,
Christoph

