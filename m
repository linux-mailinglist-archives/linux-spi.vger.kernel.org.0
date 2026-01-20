Return-Path: <linux-spi+bounces-12517-lists+linux-spi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-spi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPA2J+i7b2kOMQAAu9opvQ
	(envelope-from <linux-spi+bounces-12517-lists+linux-spi=lfdr.de@vger.kernel.org>)
	for <lists+linux-spi@lfdr.de>; Tue, 20 Jan 2026 18:31:20 +0100
X-Original-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 409CD4897A
	for <lists+linux-spi@lfdr.de>; Tue, 20 Jan 2026 18:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3EF5462DB35
	for <lists+linux-spi@lfdr.de>; Tue, 20 Jan 2026 16:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D63336EFE;
	Tue, 20 Jan 2026 16:49:29 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3C533C1AA
	for <linux-spi@vger.kernel.org>; Tue, 20 Jan 2026 16:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768927769; cv=none; b=pReB4MCNKmDLSXv2OmXjR62kRgKqdI7npkkEu5r+8XqJC1VcUlPxrbfo86k+p8efIowxxSJD0/lWlN1UEK5OsKsX4QtykiSHE+t3HqUqw+/+MvDnaUa58hWts9zkWYNGUAMbw9WZjlxDpgyZTLRQMLbdHdaF6rX8uNs3RswWiqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768927769; c=relaxed/simple;
	bh=2d/yq3knosW3zJWdHQ0Y2S8XqNnUEApPAlaIucvUJ1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMdzP/Oqcvx1BLNnOPpE4wE29whrdZxkTtExO+NsnF5KQQasV47gdoNoGSVQ+qpNK6zNn8YEM4jdujKmWJQxos4lS0+CKo1lqDcwSU8T34c5Z962wuUuiNso1Unn4XV5MmbAI9TBs3J5gIiXMKWdFZ1sg/Z9fTUlzAxBvseTX0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-4041500d9c3so3571944fac.2
        for <linux-spi@vger.kernel.org>; Tue, 20 Jan 2026 08:49:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768927765; x=1769532565;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dak1Qm1DFpV4V+FwYEI/GqMZJDhTig5zKh8vic31T98=;
        b=nKRyMcEJU0Mj2ZI3APnNJGWnzs302JD0FQIlQu7hxkSxQdWfDMtxM63N3FGPyM7FXP
         P2EwNKly1oHIGRgHdMlHeWT48rS8K8lnp8xD5BvZZFTi7YqlX5tACrtx7jw1Qw0Jy5MQ
         On09pyhv8qTL9Q3lcUKQmJrUYNEGiQV8QaXfUeDqv7S/zAwApaIWe0z+JyxRNlYQ4m9e
         lf/pq0mfVqZdo8Umtct2QO2XjkOE2J4jZ3sBXVIg3M8Kvapdeornqj9cEBZRWmADsXgP
         wbYM/sTJDDlKAKGBS0RWxXVFqMPiy1KfhgZ+Q8DiUuWxB1lMQ6dYES8j87TnJaAq2G7R
         +Z6g==
X-Forwarded-Encrypted: i=1; AJvYcCXt0VzGQ9F23VdANDwxQUe9xTDjfEjVZGnlEa2LiFqU5EZlFuHqKfNQxkrxfHSojIgdjajTxoHlkZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyJQMlwMW5ZSVLgT8OueKRuGYXxilQubdbcYaqNDesD0VSRk0n
	67EpIWdCs1T05ZEml1nOV8lBd6SYaLqoOTD0eOo/WOBVpjWoWNyhVosG
X-Gm-Gg: AZuq6aIBTAaUyNbJttsb6qDcpEH8OBx/jNhx6Q5sThCTKHiirRHpWTtZGBW+oeJDVCa
	5zWDVAuf3qPJeK1k2xNAapY6EJb3URGbQOuu6b5BPJXmgCEM8YvZl9/NDJsjZKOdKymWEeg/JCx
	7matoltTCgCrGtSM8SYpvz47CG3ymMGJzFnb2MvbgPsKliDTAsn8/vnpjeZlTV/U0gDnFKIeVWV
	5pDWKkIS7qxdmeqeMt31GU9JUnUIGIQHSBcMatszHEa9emH3/YD1hhZMv8GFdlo3ysP87DnoIN6
	AgJabsg1LEdGZud+0s75inu3OX3zlRBPODw00g9AtwUfZCYIFRRz84SXeewbmRZY5E9GuuhH621
	x7OI+AzHL7kns8bhIIWEfcXSz4pMV/BI+N/NixZlWcHrgoMLvF1beSsxlGhWDKtEA2vEAIolzQ4
	vOqw==
X-Received: by 2002:a05:6871:b29:b0:404:436d:66ce with SMTP id 586e51a60fabf-40846cf716bmr1210488fac.23.1768927765181;
        Tue, 20 Jan 2026 08:49:25 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:4e::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4044bb528d5sm9336123fac.8.2026.01.20.08.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 08:49:24 -0800 (PST)
Date: Tue, 20 Jan 2026 08:49:23 -0800
From: Breno Leitao <leitao@debian.org>
To: Vishwaroop A <va@nvidia.com>
Cc: thierry.reding@gmail.com, treding@nvidia.com, jonathanh@nvidia.com, 
	skomatineni@nvidia.com, ldewangan@nvidia.com, broonie@kernel.org, 
	linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, puranjay@kernel.org, usamaarif642@gmail.com
Subject: Re: [PATCH 0/6] spi: tegra-qspi: Fix race condition causing NULL
 pointer dereference and spurious IRQ
Message-ID: <aW-seUXIJv4Lz7bK@gmail.com>
References: <20260116-tegra_xfer-v1-0-02d96c790619@debian.org>
 <20260120112242.3766700-1-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260120112242.3766700-1-va@nvidia.com>
X-Spamd-Result: default: False [-1.26 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12517-lists,linux-spi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,nvidia.com,kernel.org,vger.kernel.org,meta.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[debian.org];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-spi@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-spi];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,tpm_torture_test.sh:url]
X-Rspamd-Queue-Id: 409CD4897A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Vishwaroop,

First of all, thanks for you answer and help,  

On Tue, Jan 20, 2026 at 11:22:42AM +0000, Vishwaroop A wrote:
> Thanks for posting this series. I've been working closely with our team at 
> NVIDIA on this exact issue after the reports from Meta's fleet.
> 
> Your analysis is correct, I have some technical feedback on the series:
> 
> **Patches 1-2 (IRQ_HANDLED + spinlock for curr_xfer):
> 
> These directly address the race we identified. The spinlock-protected read of 
> curr_xfer in Patch 2 mirrors the fix we developed internally and resolves the 
> TOCTOU race between the timeout handler and the delayed ISR thread.
> 
> **Patch 3 (Spinlock in tegra_qspi_setup_transfer_one): Improves formal correctness**
> 
> While our original position was that this lock isn't strictly required due to 
> call ordering (setup completes before HW start, so no IRQ can fire yet), I 
> agree that explicit locking here improves maintainability. It makes the 
> synchronization model clearer for future readers and removes any dependency on 
> implicit ordering guarantees.
> 
> **Patch 4 (device_reset_optional):
> 
> Your observation about ACPI platforms lacking _RST is accurate. On server 
> platforms, device_reset() fails and logs unnecessary errors. 
> device_reset_optional() is the right semantic here. I'd suggest coordinating 
> with the device core maintainers (Greg KH, Rafael Wysocki) to ensure this API 
> addition gets proper review—it's useful beyond just QSPI.

We are counting patch numbers differently. Patch 4 in this patchset is called
"[PATCH 4/6] spi: tegra210-quad: Protect curr_xfer in tegra_qspi_combined_seq_xfer",
 and basically protect the curr_xfer clearing at the exit path of
tegra_qspi_combined_seq_xfer() with the spinlock to prevent a race with the
interrupt handler that reads this field.

https://lore.kernel.org/all/20260116-tegra_xfer-v1-4-02d96c790619@debian.org/

The discussion about device_reset_optional() happened a while ago (March 2025),
but it never landed. Do you want me to include in this patchset?

Here is the discussion link:
https://lore.kernel.org/all/20250317-tegra-v1-1-78474efc0386@debian.org/

> **Patch 6 (Timeout error path): Logic issue—needs rework**

I understand you are talking about patch "[PATCH 1/6] spi:
tegra210-quad: Return IRQ_HANDLED when timeout already processed
transfer", right?

https://lore.kernel.org/all/20260116-tegra_xfer-v1-1-02d96c790619@debian.org/

> I see a problem here. If QSPI_RDY is not set (hardware actually timed out), 
> you return success (0) from tegra_qspi_handle_timeout(). This causes 
> __spi_transfer_message_noqueue() to call spi_finalize_current_message() with 
> status = 0, signaling success to the client when the transfer actually failed.
> 
> The correct behavior should be:
> - If QSPI_RDY is set: Hardware completed, recover the data, return success (0)
> - If QSPI_RDY is NOT set: True timeout, reset hardware, return error (-ETIMEDOUT)

Thanks for the heads-up.

> The current logic inverts this. I'd suggest:
> 
>   if (fifo_status & QSPI_RDY) {
>       /* HW completed, recover */
>       handle_cpu/dma_based_xfer();
>       return 0;
>   }
>   /* True timeout */
>   dev_err(..., "Transfer timeout");
>   tegra_qspi_handle_error(tqspi);
>   return -ETIMEDOUT;

I am not sure we can return -ETIMEDOUT here, given its return function
is irqreturn, which is:

  /**
   * enum irqreturn - irqreturn type values
   * @IRQ_NONE:           interrupt was not from this device or was not handled
   * @IRQ_HANDLED:        interrupt was handled by this device
   * @IRQ_WAKE_THREAD:    handler requests to wake the handler thread
   */
  enum irqreturn {
          IRQ_NONE                = (0 << 0),
          IRQ_HANDLED             = (1 << 0),
          IRQ_WAKE_THREAD         = (1 << 1),
  };


What about something as:

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index cdc3cb7c01f9b..028b0b0cfdb25 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1552,15 +1552,30 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
 static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
 {
        struct tegra_qspi *tqspi = context_data;
+       u32 status;
+
+       /*
+        * Read transfer status to check if interrupt was triggered by transfer
+        * completion
+        */
+       status = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);

        /*
         * Occasionally the IRQ thread takes a long time to wake up (usually
         * when the CPU that it's running on is excessively busy) and we have
         * already reached the timeout before and cleaned up the timed out
         * transfer. Avoid any processing in that case and bail out early.
+        *
+        * If no transfer is in progress, check if this was a real interrupt
+        * that the timeout handler already processed, or a spurious one.
         */
-       if (!tqspi->curr_xfer)
+       if (!tqspi->curr_xfer) {
+               /* Spurious interrupt - transfer not ready */
+               if (!(status & QSPI_RDY))
+                       return IRQ_HANDLED;
+               /* Real interrupt, already handled by timeout path */
                return IRQ_NONE;
+       }

        tqspi->status_reg = tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);


> I saw your tpm_torture_test.sh in the cover letter. We haven't been able to 
> reproduce the issue locally yet—it seems to require the specific TPM device 
> configuration and CPU load patterns present in Meta's fleet. 

You can try to simulate a timeout using something like:

t a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index cdc3cb7c01f9..7116c876c62b 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -159,7 +159,8 @@
 #define DATA_DIR_TX                            BIT(0)
 #define DATA_DIR_RX                            BIT(1)

-#define QSPI_DMA_TIMEOUT                       (msecs_to_jiffies(1000))
+/* INSTRUMENTATION: Reduced from 1000ms to 20ms to trigger timeouts */
+#define QSPI_DMA_TIMEOUT                       (msecs_to_jiffies(20))
 #define DEFAULT_QSPI_DMA_BUF_LEN               SZ_64K

 enum tegra_qspi_transfer_type {
@@ -1552,6 +1553,10 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
 static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
 {
        struct tegra_qspi *tqspi = context_data;
+       mdelay(10);

        /*
         * Occasionally the IRQ thread takes a long time to wake up (usually

I've also uploaded another stress test in
https://github.com/leitao/debug/tree/main/arm/tegra. Those are the  
stress test I am using to reproduce this issue.

> If you have 
> additional details on the reproduction environment (TPM vendor/model, specific 
> workload characteristics, CPU affinity settings), that would help us validate 
> the fix on our end.

I am not doing anything special, this is a bit more about my host:

  # dmesg | grep tegra
  [    8.903792] tegra-qspi NVDA1513:00: cannot use DMA: -19
  [    8.903806] tegra-qspi NVDA1513:00: falling back to PIO
  [    8.903811] tegra-qspi NVDA1513:00: device reset failed

  # udevadm info -a /dev/tpm0  | cat
  looking at device '/devices/platform/NVDA1513:00/spi_master/spi0/spi-PRP0001:01/tpm/tpm0':
    KERNEL=="tpm0"
    SUBSYSTEM=="tpm"
    DRIVER==""
    ATTR{null_name}=="000bb4c148f37daef5c917ebdd9267edad857263b872d9a9cd05f2af96c060212e6f"
    ATTR{pcr-sha256/0}=="9CC1646906FD362B5F6D182CBADE226057CD32A6F5D6C6197A49AA78B4241929"
    ATTR{pcr-sha256/1}=="BFB3D60EA045EE30E924F239C812E11D7D02D380D94B1A53CDF8E336F4BD5EFF"
    ATTR{pcr-sha256/10}=="0000000000000000000000000000000000000000000000000000000000000000"
    ATTR{pcr-sha256/11}=="0000000000000000000000000000000000000000000000000000000000000000"
    ATTR{pcr-sha256/12}=="0000000000000000000000000000000000000000000000000000000000000000"
    ATTR{pcr-sha256/13}=="0000000000000000000000000000000000000000000000000000000000000000"
    ATTR{pcr-sha256/14}=="0000000000000000000000000000000000000000000000000000000000000000"
    ATTR{pcr-sha256/15}=="0000000000000000000000000000000000000000000000000000000000000000"
    ATTR{pcr-sha256/16}=="0000000000000000000000000000000000000000000000000000000000000000"
    ATTR{pcr-sha256/17}=="FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF"
    ATTR{pcr-sha256/18}=="FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF"
    ATTR{pcr-sha256/19}=="FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF"
    ATTR{pcr-sha256/2}=="ECE24999889A3DBA6BDC392ED64CA0B6A968DFCAF46D8DBDDAD57A7A0423AD2C"
    ATTR{pcr-sha256/20}=="FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF"
    ATTR{pcr-sha256/21}=="FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF"
    ATTR{pcr-sha256/22}=="FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF"
    ATTR{pcr-sha256/23}=="0000000000000000000000000000000000000000000000000000000000000000"
    ATTR{pcr-sha256/3}=="3D458CFE55CC03EA1F443F1562BEEC8DF51C75E14A9FCF9A7234A13F198E7969"
    ATTR{pcr-sha256/4}=="7E7811C1F6A74895706FFFBED8180452AABA032209D708A7B08066B16F38524F"
    ATTR{pcr-sha256/5}=="D679AB040FA69F51A392DC467BA09AC0A5040FAAD386A9DA99A23C465DB0BCE1"
    ATTR{pcr-sha256/6}=="3D458CFE55CC03EA1F443F1562BEEC8DF51C75E14A9FCF9A7234A13F198E7969"
    ATTR{pcr-sha256/7}=="65CAF8DD1E0EA7A6347B635D2B379C93B9A1351EDC2AFC3ECDA700E534EB3068"
    ATTR{pcr-sha256/8}=="0000000000000000000000000000000000000000000000000000000000000000"
    ATTR{pcr-sha256/9}=="94BACCCA95B21E689C38511D4FE26D2DCB1E2C20CD5CECC5C4F2FC99C28452BF"
    ATTR{power/control}=="auto"
    ATTR{power/runtime_active_time}=="0"
    ATTR{power/runtime_status}=="unsupported"
    ATTR{power/runtime_suspended_time}=="0"
    ATTR{tpm_version_major}=="2"

  looking at parent device '/devices/platform/NVDA1513:00/spi_master/spi0/spi-PRP0001:01':
    KERNELS=="spi-PRP0001:01"
    SUBSYSTEMS=="spi"
    DRIVERS=="tpm_tis_spi"
    ATTRS{driver_override}==""
    ATTRS{power/control}=="auto"
    ATTRS{power/runtime_active_time}=="0"
    ATTRS{power/runtime_status}=="unsupported"
    ATTRS{power/runtime_suspended_time}=="0"
    ATTRS{statistics/bytes}=="0"
    ATTRS{statistics/bytes_rx}=="0"
    ATTRS{statistics/bytes_tx}=="0"
    ATTRS{statistics/errors}=="0"
    ATTRS{statistics/messages}=="0"
    ATTRS{statistics/spi_async}=="0"
    ATTRS{statistics/spi_sync}=="3542838"
    ATTRS{statistics/spi_sync_immediate}=="3542838"
    ATTRS{statistics/timedout}=="0"
    ATTRS{statistics/transfer_bytes_histo_0-1}=="0"
    ATTRS{statistics/transfer_bytes_histo_1024-2047}=="0"
    ATTRS{statistics/transfer_bytes_histo_128-255}=="0"
    ATTRS{statistics/transfer_bytes_histo_16-31}=="0"
    ATTRS{statistics/transfer_bytes_histo_16384-32767}=="0"
    ATTRS{statistics/transfer_bytes_histo_2-3}=="0"
    ATTRS{statistics/transfer_bytes_histo_2048-4095}=="0"
    ATTRS{statistics/transfer_bytes_histo_256-511}=="0"
    ATTRS{statistics/transfer_bytes_histo_32-63}=="0"
    ATTRS{statistics/transfer_bytes_histo_32768-65535}=="0"
    ATTRS{statistics/transfer_bytes_histo_4-7}=="0"
    ATTRS{statistics/transfer_bytes_histo_4096-8191}=="0"
    ATTRS{statistics/transfer_bytes_histo_512-1023}=="0"
    ATTRS{statistics/transfer_bytes_histo_64-127}=="0"
    ATTRS{statistics/transfer_bytes_histo_65536+}=="0"
    ATTRS{statistics/transfer_bytes_histo_8-15}=="0"
    ATTRS{statistics/transfer_bytes_histo_8192-16383}=="0"
    ATTRS{statistics/transfers}=="0"
    ATTRS{statistics/transfers_split_maxsize}=="0"

  looking at parent device '/devices/platform/NVDA1513:00/spi_master/spi0':
    KERNELS=="spi0"
    SUBSYSTEMS=="spi_master"
    DRIVERS==""
    ATTRS{power/control}=="auto"
    ATTRS{power/runtime_active_time}=="0"
    ATTRS{power/runtime_status}=="unsupported"
    ATTRS{power/runtime_suspended_time}=="0"
    ATTRS{statistics/bytes}=="0"
    ATTRS{statistics/bytes_rx}=="0"
    ATTRS{statistics/bytes_tx}=="0"
    ATTRS{statistics/errors}=="0"
    ATTRS{statistics/messages}=="0"
    ATTRS{statistics/spi_async}=="0"
    ATTRS{statistics/spi_sync}=="3542838"
    ATTRS{statistics/spi_sync_immediate}=="3542838"
    ATTRS{statistics/timedout}=="0"
    ATTRS{statistics/transfer_bytes_histo_0-1}=="0"
    ATTRS{statistics/transfer_bytes_histo_1024-2047}=="0"
    ATTRS{statistics/transfer_bytes_histo_128-255}=="0"
    ATTRS{statistics/transfer_bytes_histo_16-31}=="0"
    ATTRS{statistics/transfer_bytes_histo_16384-32767}=="0"
    ATTRS{statistics/transfer_bytes_histo_2-3}=="0"
    ATTRS{statistics/transfer_bytes_histo_2048-4095}=="0"
    ATTRS{statistics/transfer_bytes_histo_256-511}=="0"
    ATTRS{statistics/transfer_bytes_histo_32-63}=="0"
    ATTRS{statistics/transfer_bytes_histo_32768-65535}=="0"
    ATTRS{statistics/transfer_bytes_histo_4-7}=="0"
    ATTRS{statistics/transfer_bytes_histo_4096-8191}=="0"
    ATTRS{statistics/transfer_bytes_histo_512-1023}=="0"
    ATTRS{statistics/transfer_bytes_histo_64-127}=="0"
    ATTRS{statistics/transfer_bytes_histo_65536+}=="0"
    ATTRS{statistics/transfer_bytes_histo_8-15}=="0"
    ATTRS{statistics/transfer_bytes_histo_8192-16383}=="0"
    ATTRS{statistics/transfers}=="0"
    ATTRS{statistics/transfers_split_maxsize}=="0"

  looking at parent device '/devices/platform/NVDA1513:00':
    KERNELS=="NVDA1513:00"
    SUBSYSTEMS=="platform"
    DRIVERS=="tegra-qspi"
    ATTRS{driver_override}=="(null)"
    ATTRS{power/control}=="auto"
    ATTRS{power/runtime_active_time}=="86751"
    ATTRS{power/runtime_status}=="suspended"
    ATTRS{power/runtime_suspended_time}=="340179486"

  looking at parent device '/devices/platform':
    KERNELS=="platform"
    SUBSYSTEMS==""
    DRIVERS==""
    ATTRS{power/control}=="auto"
    ATTRS{power/runtime_active_time}=="0"
    ATTRS{power/runtime_status}=="unsupported"
    ATTRS{power/runtime_suspended_time}=="0"

> I'm happy to:
> - Test this series on our hardware platforms

Please test with the patch above (reduced QSPI_DMA_TIMEOUT and the mdelay). 

> - Collaborate on v2 with the fixes above

Thanks. I understand that the only concern for v1 is that QSPI_RDY if inverted,
and I can fix it and send a v2. is there anything else you want fixed in v2?

> - I will work on hard IRQ handler follow-up that Thierry suggested for 
>   long-term robustness

This is awesome, appreciate!

Thanks for you support,
--breno

