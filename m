Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C816617E79E
	for <lists+linux-spi@lfdr.de>; Mon,  9 Mar 2020 19:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgCISyg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 14:54:36 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]:45433 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbgCISyf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Mar 2020 14:54:35 -0400
Received: by mail-qt1-f177.google.com with SMTP id a4so7791888qto.12
        for <linux-spi@vger.kernel.org>; Mon, 09 Mar 2020 11:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ossystems-com-br.20150623.gappssmtp.com; s=20150623;
        h=from:mime-version:date:message-id:subject:to;
        bh=gW+iriUdtxlZCcttcADThfqktlutCqmObVsZzeSTfPY=;
        b=v2chXXaRVG5vuD5kFLHQEDXvsMGK7uIFfVzTpEx4AhLStQHihyDwaC77PFehhKa/wG
         D5EyVVhEEUautHa79a2pTHhObnj5dHWkr7paCh+GgcmJuRYzApZHvrXOHR43/a5K4J4d
         b/Y3Rnr+mTwYV5ryUhPBulYrGmMv6t2ELiC6KFi0pqgl0qy6DlyfPVNMMGhj4jxuwyBX
         NwXSLl72YQM1B12SSU8om0b2c9UML098raw/p3q2Gc7Um84j85VmGKFyuoiOgYuZJB2N
         FhHswBvNDGaC2AaCtVkEwhRw8xZj6/15iBTAMH9fggJTZhFt+vTySFcL/5ZmEJpJHHjZ
         4JTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:date:message-id:subject:to;
        bh=gW+iriUdtxlZCcttcADThfqktlutCqmObVsZzeSTfPY=;
        b=MC2TOXOqRZcUCEwU/7YbcY8XThLFz18OFEdy+Zss72M4MdKsY8OnOkF96OWR+FuQoJ
         j9TLEPyydQ0HYsRXRyHkwFIQc9AYw/D8BX6MPTEXWwZ8xfwhDsn+52RHWiitMnuEDTYX
         F5MyCSwCWxY2JdCx7DJaNnaMjzvA7xCrViDabvaDCJ2vNOOgNN+spk2scUIsr+f3kAE1
         IdHnokbs8SEt/P/ZcBJW0mYc9tkC2x/koHv3s7UsYwvC8zbuBERw7pxIbDOC8G4EhHl0
         8lE/74bgP/dFjnLhOtJNgxEXJmqmFZYGOw1mQ1xqrtaI9f+eIeDwgNHxB2vCQOjefIUW
         PbRQ==
X-Gm-Message-State: ANhLgQ0TAHTT2hXcug9BMITyHf+UNkanwcRSRkDzmkXt2BOmlAOUyS0C
        /xfX9MB4OGB8TjIST13T3PQswDwKHmHd7g==
X-Google-Smtp-Source: ADFU+vuZgAuizDuScmVjSGX3IdB0FZmlBeoVIiZmCf+5MIxh786aNzPiTT3cxVzp93UXefCUjS1u7w==
X-Received: by 2002:ac8:4d97:: with SMTP id a23mr11956040qtw.176.1583780074221;
        Mon, 09 Mar 2020 11:54:34 -0700 (PDT)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id l12sm6130430qtp.44.2020.03.09.11.54.32
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2020 11:54:33 -0700 (PDT)
From:   Otavio Salvador <otavio.salvador@ossystems.com.br>
X-Google-Original-From: Otavio Salvador <otavio@ossystems.com.br>
Received: by mail-qt1-f170.google.com with SMTP id h16so7797212qtr.11
        for <linux-spi@vger.kernel.org>; Mon, 09 Mar 2020 11:54:32 -0700 (PDT)
X-Received: by 2002:ac8:607:: with SMTP id d7mr15667506qth.271.1583780072098;
 Mon, 09 Mar 2020 11:54:32 -0700 (PDT)
MIME-Version: 1.0
Date:   Mon, 9 Mar 2020 15:54:20 -0300
X-Gmail-Original-Message-ID: <CAP9ODKpW=h6SVtsn-uuDQ4+TgR0NnjBW==8vwyQD4+x_dbFzRQ@mail.gmail.com>
Message-ID: <CAP9ODKpW=h6SVtsn-uuDQ4+TgR0NnjBW==8vwyQD4+x_dbFzRQ@mail.gmail.com>
Subject: SPI irq regression
To:     kernel@esmil.dk, Heiko Stuebner <heiko@sntech.de>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

Since commit:

commit 01b59ce5dac856323a0c13c1d51d99a819f32efe
Author: Emil Renner Berthing <kernel@esmil.dk>
Date:   Wed Oct 31 11:57:09 2018 +0100

    spi: rockchip: use irq rather than polling

    Register an interrupt handler to fill/empty the
    tx and rx fifos rather than busy-looping.

    Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
    Tested-by: Heiko Stuebner <heiko@sntech.de>
    Signed-off-by: Mark Brown <broonie@kernel.org>

SPI is no longer functional on a RV1108 Elgin board.

The error messages are:

[   46.186916] spidev spi0.0: SPI transfer timed out
[   46.187435] spi_master spi0: failed to transfer one message from queue

Reverting this commit makes SPI to work again.

Any ideas on how we can properly fix this regression?

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9 9981-7854          Mobile: +1 (347) 903-9750
