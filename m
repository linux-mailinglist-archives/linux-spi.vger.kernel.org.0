Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34971179B65
	for <lists+linux-spi@lfdr.de>; Wed,  4 Mar 2020 23:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgCDWB5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Mar 2020 17:01:57 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:45374 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbgCDWB5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Mar 2020 17:01:57 -0500
Received: by mail-wr1-f52.google.com with SMTP id v2so4422266wrp.12;
        Wed, 04 Mar 2020 14:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XQ99deIahy3PZQjVM3HXuQCtzcwKDNaywaomNehfdvk=;
        b=WjHT4FirpV1djTsAAwtCP5mAtEBw6pqd+VN86m82Fd49t/GEFqw5843aRDKjB3gFhS
         MzZ6qdl7rkvm+09NjzUa7PkRkVqm7P9VUPkwpVC6VvmtknGUFnOxLF3dLX2GLmMTyIUl
         SkbCXBA+l4TK1DpqWI1pqG/BRlD8N9gq4xt/XXZ4ichScMpoiq91OLYh3cZXMQPrDtee
         0E+Fd8XGiXgCVIl3OR9Z/hVXt6slLBskjgKBhlNm5nIG/RIAVa0EDKSZTmkxhMO5DwrV
         p5TbOe2g27poeG9tTe4bm8pr3ooxAjCRdFcANNpkT4mpp0c3thSmQZlmsm1P9IG9uy7X
         xapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XQ99deIahy3PZQjVM3HXuQCtzcwKDNaywaomNehfdvk=;
        b=dlOu9kpo60dtOGuZHuPaHvOscYh3GjD35n+KvLVQfxAYvCJwK3pP5IUVLUvt2hWDao
         jfsUyfhaOAk0aWnkp7zxS/S8qQ4P4jVVdLD4Aq2luUPLvxXpM0JQaJU8TV+BzyzXdZum
         tQPj1W/OrzwPTVEMyrx676goULYvke67ZU9Grhvq9cgO50cwZ2fxYpv8C4QV/arBmveh
         cxqi8KZiASrBfcWlG2AT9wjpabdlWHCqeRnnDhMtwctWzzO/trhPI8VEvKIi1aDm0iB3
         z9z7OM6LMJPioBE6kuOF5++EkwAhIXfGCKnRgoimGIxAFW7M5LPGtEAx+ZbnDjT7brby
         ebrw==
X-Gm-Message-State: ANhLgQ2KnXdJd5iIpO1TeS2mkyE9ZBzBp6VpITPyiVglPzNJLeaSWqw8
        cVg/ruI9MTbExOGRYb2thXE=
X-Google-Smtp-Source: ADFU+vtcKt4tc8nujavxcSjtd08cxMiRrXKihg4E1AZz8RytVfpxGUQ9z3VAvsDtvPWJQKpfOMnANw==
X-Received: by 2002:a5d:6146:: with SMTP id y6mr6068304wrt.107.1583359314958;
        Wed, 04 Mar 2020 14:01:54 -0800 (PST)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id z2sm36776402wrq.95.2020.03.04.14.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 14:01:54 -0800 (PST)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        eha@deif.com, angelo@sysam.it, andrew.smirnov@gmail.com,
        gustavo@embeddedor.com, weic@nvidia.com, mhosny@nvidia.com
Subject: [PATCH 00/12] TCFQ to XSPI migration for NXP DSPI driver
Date:   Thu,  5 Mar 2020 00:00:32 +0200
Message-Id: <20200304220044.11193-1-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

This series aims to remove the most inefficient transfer method from the
NXP DSPI driver.

TCFQ (Transfer Complete Flag) mode works by transferring one word,
waiting for its TX confirmation interrupt (or polling on the equivalent
status bit), sending the next word, etc, until the buffer is complete.

The issue with this mode is that it's fundamentally incompatible with
any sort of batching such as writing to a FIFO. But actually, due to
previous patchset ("Compatible string consolidation for NXP DSPI driver"):

https://patchwork.kernel.org/cover/11414593/

all existing users of TCFQ mode today already support a more advanced
feature set, in the form of XSPI (extended SPI). XSPI brings 2 extra
features:

- Word sizes up to 32 bits. This is sub-utilized today, and acceleration
  of smaller-than-32 bpw values is provided.
- "Command cycling", basically the ability to write multiple words in a
  row and receiving an interrupt only after the completion of the last
  one. This is what enables us to make use of the full FIFO depth of
  this controller.

Series was tested on the NXP LS1021A-TSN and LS1043A-RDB boards, both
functionally as well as from a performance standpoint.

The command used to benchmark the increased throughput was:

spidev_test --device /dev/spidev1.0 --bpw 8 --size 256 --cpha --iter 10000000 --speed 20000000

where spidev1.0 is a dummy spidev node, using a chip select that no
peripheral responds to.

On LS1021A, which has a 4-entry-deep FIFO and a less powerful CPU, the
performance increase brought by this patchset is from 2700 kbps to 5800
kbps.

On LS1043A, which has a 16-entry-deep FIFO and a more powerful CPU, the
performance increases from 4100 kbps to 13700 kbps.

On average, SPI software timestamping is not adversely affected by the
extra batching, due to the extra patches.

There is one extra patch which clarifies why the TCFQ users were not
converted to the "other" mode in this driver that makes use of the FIFO,
which would be EOQ mode.

My request to the many people on CC (known users and/or contributors) is
to give this series a test to ensure there are no regressions, and for
the Coldfire maintainers to clarify whether the EOQ limitation is
acceptable for them in the long run.

Vladimir Oltean (12):
  spi: spi-fsl-dspi: Simplify bytes_per_word gymnastics
  spi: spi-fsl-dspi: Remove unused chip->void_write_data
  spi: spi-fsl-dspi: Don't mask off undefined bits
  spi: spi-fsl-dspi: Add comments around dspi_pop_tx and dspi_push_rx
    functions
  spi: spi-fsl-dspi: Rename fifo_{read,write} and {tx,cmd}_fifo_write
  spi: spi-fsl-dspi: Implement .max_message_size method for EOQ mode
  spi: Do spi_take_timestamp_pre for as many times as necessary
  spi: spi-fsl-dspi: Convert TCFQ users to XSPI FIFO mode
  spi: spi-fsl-dspi: Accelerate transfers using larger word size if
    possible
  spi: spi-fsl-dspi: Optimize dspi_setup_accel for lowest interrupt
    count
  spi: spi-fsl-dspi: Use EOQ for last word in buffer even for XSPI mode
  spi: spi-fsl-dspi: Take software timestamp in dspi_fifo_write

 drivers/spi/spi-fsl-dspi.c | 421 ++++++++++++++++++++++++-------------
 drivers/spi/spi.c          |  19 +-
 include/linux/spi/spi.h    |   3 +-
 3 files changed, 288 insertions(+), 155 deletions(-)

-- 
2.17.1

