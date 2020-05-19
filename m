Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6899E1D99DF
	for <lists+linux-spi@lfdr.de>; Tue, 19 May 2020 16:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbgESOd6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 May 2020 10:33:58 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:51753 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgESOd6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 May 2020 10:33:58 -0400
X-Originating-IP: 86.210.146.109
Received: from windsurf.home (lfbn-tou-1-915-109.w86-210.abo.wanadoo.fr [86.210.146.109])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id A4C3F240008;
        Tue, 19 May 2020 14:33:55 +0000 (UTC)
Date:   Tue, 19 May 2020 16:33:53 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Jan =?UTF-8?B?S3VuZHLDoXQ=?= <jan.kundrat@cesnet.cz>
Subject: High CPU load when using MAX14830 SPI UART controller
Message-ID: <20200519163353.20c03286@windsurf.home>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,

I have an ARM platform based on the Microchip SAMA5D3 processor
(single Cortex-A5 at 536 Mhz), which has a MAX14830 (datasheet at [0],
driver at drivers/tty/serial/max310x.c) UART controller on SPI. I'm
running an unmodified Linux 5.6 kernel. The SPI controller driver for
that platform is drivers/spi/spi-atmel.c.

[0] https://datasheets.maximintegrated.com/en/ds/MAX14830.pdf

I have a remote machine sending data at 57600 bps over one of the four
UARTs provided by the MAX14830. The data is sent 20 bytes at a time,
every 16 ms. This means 1250 bytes per second total, i.e a pretty
ridiculous amount of data being transferred.

But interestingly, this simple data transfer causes a constant 32% CPU
load on the SAMA5D3 in the kernel side. top shows:

Mem: 38204K used, 208404K free, 156K shrd, 4672K buff, 14660K cached
CPU:   0% usr  32% sys   0% nic  66% idle   0% io   0% irq   0% sirq

So, 32% of the time spent in the "system". More precisely, it shows:

  PID  PPID USER     STAT   VSZ %VSZ %CPU COMMAND
   80     2 root     SW       0   0%  21% [irq/50-spi1.3]
   79     2 root     SW       0   0%   5% [spi1]
  174     2 root     IW       0   0%   5% [kworker/u2:2-ev]
   82     2 root     IW       0   0%   2% [kworker/0:2-eve]
  256   243 root     S     1356   1%   1% ./progread /dev/ttyMAX0

"progread" is the program reading the data out of the UART (it does
nothing with it, except check it is valid). irq/50-spi1.3 is the
threaded IRQ of the MAX14830 driver. spi1 is I assume the kthread of
the SPI subsystem.

With the sending of 20 bytes data frames every 16 ms, it means data is
send ~62.5 per seconds.

Looking at /proc/interrupts, I get ~260 interrupts per second on the
MAX14830, which means that the "batch reading" implemented in
2b4bac48c10848ccffd484e7cd025dc085c1bd32 is effective but not to the
point where I have a single interrupt per received frame. Every
second, I'm also getting 7500-7700 interrupts from the SPI controller
of the SAMA5.

"perf top" is not extremely helpful:

   PerfTop:    1097 irqs/sec  kernel:90.0%  exact:  0.0% [4000Hz cycles],  (all, 1 CPU)
-------------------------------------------------------------------------------

    40.10%  [kernel]       [k] finish_task_switch
     8.52%  [kernel]       [k] atmel_spi_transfer_one_message
     3.92%  [kernel]       [k] schedule_timeout
     2.41%  [kernel]       [k] __softirqentry_text_start
     2.32%  [kernel]       [k] __sched_text_start
     2.26%  [kernel]       [k] arch_cpu_idle
     1.92%  [kernel]       [k] __spi_pump_messages
     1.79%  [kernel]       [k] spi_finalize_current_message
     1.62%  [kernel]       [k] __spi_validate
     1.29%  [kernel]       [k] schedule
     0.84%  [kernel]       [k] _regmap_raw_read
     0.83%  [kernel]       [k] complete
     0.76%  [kernel]       [k] __spi_sync
     0.76%  [kernel]       [k] __ksize
     0.65%  [kernel]       [k] _regmap_read
     0.64%  libc-2.30.so   [.] strcmp
     0.60%  [kernel]       [k] mmioset
     0.59%  [kernel]       [k] del_timer.part.0
     0.58%  [kernel]       [k] wait_for_completion_timeout
     0.57%  [kernel]       [k] regmap_readable

perf record/report gives:

    19.42%  spi1             [kernel.kallsyms]  [k] finish_task_switch
    17.42%  kworker/u2:1-ev  [kernel.kallsyms]  [k] finish_task_switch
     9.22%  irq/50-spi1.3    [kernel.kallsyms]  [k] atmel_spi_transfer_one_message
     7.76%  irq/50-spi1.3    [kernel.kallsyms]  [k] finish_task_switch
     4.15%  irq/50-spi1.3    [kernel.kallsyms]  [k] schedule_timeout
     4.15%  kworker/0:2-eve  [kernel.kallsyms]  [k] finish_task_switch
     2.25%  swapper          [kernel.kallsyms]  [k] arch_cpu_idle
     1.94%  irq/50-spi1.3    [kernel.kallsyms]  [k] __spi_pump_messages
     1.84%  irq/50-spi1.3    [kernel.kallsyms]  [k] __spi_validate
     1.78%  irq/50-spi1.3    [kernel.kallsyms]  [k] spi_finalize_current_message

Does the very high CPU time spent in finish_task_switch() simply means
that we're scheduling too much ?

Any hints on how to improve this situation ?

Best regards,

Thomas Petazzoni
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
